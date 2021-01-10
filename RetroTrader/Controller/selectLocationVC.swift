//
//  firstVC.swift
//  RetroTrader
//
//  Created by Gary Naz on 1/4/21.
//

import Foundation
import MapKit


protocol AddLocationDelegate : AnyObject {
    func didAddLocation(longitude: Double, latitude: Double, name: String)
}

class selectLocationVC : UIViewController {
    
    public weak var locationDelegate : AddLocationDelegate? = nil
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil

    lazy var leftBarButton =  UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
    lazy var rightBarButton =  UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(add))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        view.addSubview(mapView)
        mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        let locationSearchTable = LocationSearchTable()
        locationSearchTable.handleMapSearchDelegate = self
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.searchController = resultSearchController
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
    }
    
    deinit {
        print("Release memory from firstVC.")
    }
    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func add(){
        //Save placemark.name and placemark.coordinate to Core Data to later display in ProductInfoVC.
        locationDelegate?.didAddLocation(longitude: selectedPin!.coordinate.longitude, latitude: selectedPin!.coordinate.latitude, name: " \(selectedPin!.name!), \(selectedPin!.administrativeArea ?? "ON") \(selectedPin!.postalCode ?? "L4J9K3")")
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension selectLocationVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            break
        case .denied:
            //Show alert instructing user how to turn on permissions.
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .restricted:
            //Show alert letting user know what's going on.
            break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
}

extension selectLocationVC: HandleMapSearch {
    

    func dropPinZoomIn(placemark:MKPlacemark){
        
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
