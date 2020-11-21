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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = barButton
        view.backgroundColor = .white
    }
    
    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
