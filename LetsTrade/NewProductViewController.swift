//
//  NewProductViewController.swift
//  LetsTrade
//
//  Created by Gary Naz on 11/21/20.
//

import Foundation
import UIKit

class NewProductViewController: UIViewController {
    
    lazy var barButton =  UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
    
    let postButton : UIButton = {
        let postButton = UIButton()
        postButton.backgroundColor = .systemBlue
        postButton.setTitle("Post Ad", for: .normal)
        postButton.addTarget(self, action: #selector(newPost), for: .touchUpInside)
        postButton.layer.cornerRadius = 10
        return postButton
    }()
    
    let titleField : UITextField = {
        let titleField = UITextField()
        titleField.placeholder = "Title"
        titleField.textAlignment = .center
        titleField.backgroundColor = .systemBlue
        titleField.layer.cornerRadius = 10
        return titleField
    }()
    
    
    let priceField : UITextField = {
        let priceField = UITextField()
        priceField.placeholder = "Price"
        priceField.textAlignment = .center
        priceField.backgroundColor = .systemBlue
        priceField.layer.cornerRadius = 10
        return priceField
    }()
    
    let newImageView : UIImageView = {
        let newImageView = UIImageView()
        newImageView.image = UIImage(systemName: "photo")
        newImageView.layer.cornerRadius = 10
        return newImageView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewConfig()
        LayoutConfig()
    }
    
    
    func viewConfig(){
        navigationItem.leftBarButtonItem = barButton
        
        [postButton, titleField, priceField, newImageView].forEach{view.addSubview($0)}
    }
    
    
    
    func LayoutConfig(){
        
        titleField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 40, bottom: 650, right: 40))
        
        priceField.anchor(top: titleField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 40, bottom: 550, right: 40))
        
        newImageView.anchor(top: priceField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 50, left: 40, bottom: 250, right: 40))
        
        postButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 660, left: 40, bottom: 40, right: 40))
    }
    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func newPost(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
