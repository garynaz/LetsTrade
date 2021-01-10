//
//  showLocationVC.swift
//  RetroTrader
//
//  Created by Gary Naz on 1/9/21.
//

import Foundation
import UIKit
import MapKit

class showLocationVC: UIViewController, CLLocationManagerDelegate {
    
    var lat : Double?
    var long : Double?
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    lazy var leftBarButton =  UIBarButtonItem(title: "Go Back", style: .plain, target: self, action: #selector(goBack))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        navigationItem.leftBarButtonItem = leftBarButton
        
        let selectedLocation = MKPlacemark(coordinate: .init(latitude: lat!, longitude: long!))
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: .init(latitude: lat!, longitude: long!), span: span)
        mapView.addAnnotation(selectedLocation)
        mapView.setRegion(region, animated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        view.addSubview(mapView)
        mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    deinit {
        print("Release memory from showLocationVC.")
    }
    
    @objc func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
