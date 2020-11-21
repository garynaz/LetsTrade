//
//  ViewController.swift
//  LetsTrade
//
//  Created by Gary Naz on 11/16/20.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var myCollectionView : UICollectionView?
    let searchController = UISearchController(searchResultsController: nil)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var barButton =  UIBarButtonItem(title: "Add Item", style: .plain, target: self, action: #selector(addItem))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewNavConfig()
        
        myCollectionView?.delegate = self
        myCollectionView?.dataSource = self
        
        myCollectionView?.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.cellId)
    }
    
    
    
    
    func viewNavConfig(){
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: ViewController.createLayout())
        myCollectionView?.backgroundColor = .black
        
        view.addSubview(myCollectionView!)

        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.barStyle = .black
        navigationItem.rightBarButtonItem = barButton
        searchController.hidesNavigationBarDuringPresentation = false
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
    
    @objc func addItem(){
        let destinationVc = NewProductViewController()
        let itemNavControler = UINavigationController(rootViewController: destinationVc)
        
        self.present(itemNavControler, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.cellId, for: indexPath) as! ProductCell
        cell.configure(title: "Playstation 4", price: 200, image: "ps4")
        
        return cell
    }
    
    
    
}






extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
