//
//  ProductInfoViewController.swift
//  LetsTrade
//
//  Created by Gary Naz on 12/1/20.
//

import Foundation
import UIKit

class ProductInfoViewController : UIViewController {
    
    var selectedProduct : Product?
    
    let productImage : UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let productTitle : UILabel = {
        let title = UILabel()
        title.backgroundColor = .white
        title.textColor = .black
        title.textAlignment = .left
        return title
    }()
    
    let productPrice : UILabel = {
       let price = UILabel()
        price.backgroundColor = .white
        price.textColor = .black
        price.textAlignment = .left
        return price
    }()
    
    let productDescription : UITextView = {
        let description = UITextView()
        description.backgroundColor = .white
        description.textColor = .black
        description.textAlignment = .left
        description.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return description
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.image = UIImage(data: selectedProduct!.photo!)
        productTitle.text = selectedProduct?.title
        productPrice.text = "$\(String(selectedProduct!.price))"
        productDescription.text = selectedProduct?.additionalInfo
        productTitle.setMargins(margin: 20)
        productPrice.setMargins(margin: 20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        [productImage, productTitle, productPrice, productDescription].forEach{view.addSubview($0)}
        layoutConfig()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    func layoutConfig() {
        productImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: view.frame.height/2, right: 0))
        productTitle.anchor(top: productImage.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 380, right: 0))
        productPrice.anchor(top: productTitle.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 300, right: 0))
        productDescription.anchor(top: productPrice.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
}


