//
//  ViewController.swift
//  RetroTrader
//
//  Created by Gary Naz on 11/16/20.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate {
    
    var productData : [Product]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Product>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Product>
    private lazy var dataSource = makeDataSource()
    
    var myCollectionView : UICollectionView?
    let searchController = UISearchController(searchResultsController: nil)
    lazy var barButton =  UIBarButtonItem(title: "Add Item", style: .plain, target: self, action: #selector(addItem))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewNavConfig()
        myCollectionView?.delegate = self
        myCollectionView?.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.cellId)
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
    }
    
    deinit {
        print("Release memory from main VC.")
    }
    
    func fetchData(){
        do {
            productData = try context.fetch(Product.fetchRequest())
            applySnapshot(animatingDifferences: false, with: productData!)
        } catch {
            print("Unable to fetch data: \(error)")
        }
    }
    
    func applySnapshot(animatingDifferences: Bool = true, with product: [Product]) {
      var snapshot = Snapshot()
      snapshot.appendSections([.main])
      snapshot.appendItems(product)
      dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: myCollectionView!, cellProvider: {(collectionView, indexPath, Product) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.cellId, for: indexPath) as! ProductCell
            
            let productPhotos = self.imagesFromCoreData(object: Product.photo!)
            
            cell.configure(title: Product.title!, price: Product.price, image: productPhotos![0].pngData()!)
            cell.deleteButton.tag = indexPath.row
            return cell
        })
        return dataSource
    }
    
    
    func viewNavConfig(){
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: ViewController.createLayout())
        myCollectionView?.backgroundColor = .black
        
        view.addSubview(myCollectionView!)

        navigationItem.searchController = searchController
        navigationController?.navigationBar.barStyle = .black
        navigationItem.rightBarButtonItem = barButton
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter your search..."
    }

    static func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout.init(section: section, configuration: UICollectionViewCompositionalLayoutConfiguration())
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let infoVc = ProductInfoViewController()
        
        infoVc.selectedProduct = productData![indexPath.item]
        infoVc.imageArray = imagesFromCoreData(object: productData![indexPath.item].photo!)
        
        navigationController?.pushViewController(infoVc, animated: true)
    }
    
    @objc func deleteItem(sender:UIButton){
        
        context.delete(productData![sender.tag])

        do {
            try context.save()
        } catch {
            print("Unable to delete Item:\(error)")
        }
        fetchData()
     }
    
    
    @objc func addItem(){
        let destinationVc = NewProductViewController()
        let itemNavControler = UINavigationController(rootViewController: destinationVc)
        itemNavControler.modalPresentationStyle = .fullScreen
        self.present(itemNavControler, animated: true, completion: nil)
    }
    
    
    
    enum Section {
        case main
    }
    
    //Produces a Data object from an Array of Images.
    func coreDataObjectFromImages(images: [UIImage]) -> Data? {
        let dataArray = NSMutableArray()

        for img in images {
            if let data = img.pngData() {
                dataArray.add(data)
            }
        }
        return try? NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: true)
    }

    
    //Produces an Array of Images from a Data object.
    func imagesFromCoreData(object: Data?) -> [UIImage]? {
        var retVal = [UIImage]()

        guard let object = object else { return nil }
        if let dataArray = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: object) {
            for data in dataArray {
                if let data = data as? Data, let image = UIImage(data: data) {
                    retVal.append(image)
                }
            }
        }
        return retVal
    }
}



extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        do {
            guard let text = searchController.searchBar.text else { return }
            
            let request = Product.fetchRequest() as NSFetchRequest<Product>
            
            let pred = NSPredicate(format: "title CONTAINS %@", text)
            request.predicate = pred
            
            productData = try context.fetch(request)
            
            applySnapshot(animatingDifferences: false, with: productData!)
            
        } catch {
            print("Unable to fetch data: \(error)")
        }
        
        if !searchController.isActive
        {
            fetchData()
        }
        
    }
    
}
