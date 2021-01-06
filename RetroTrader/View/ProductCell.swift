//
//  ProductCell.swift
//  RetroTrader
//
//  Created by Gary Naz on 11/17/20.
//

import Foundation
import UIKit

class ProductCell: UICollectionViewCell {
    
   static let cellId = "ProductCellId"
    
   public let deleteButton :UIButton = {
        let deleteButton = UIButton()
        deleteButton.setImage(UIImage(systemName: "multiply.square.fill"), for: .normal)
        deleteButton.addTarget(nil, action: #selector(ViewController.deleteItem), for: .touchUpInside)
        return deleteButton
    }()
    
    private let myImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Custom"
        myLabel.textColor = .black
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0
        myLabel.clipsToBounds = true
        return myLabel
    }()
    
    private let priceLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.text = "$0"
        myLabel.textColor = .black
        myLabel.textAlignment = .center
        myLabel.clipsToBounds = true
        return myLabel
    }()
    
    private let bstLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Selling"
        myLabel.textColor = .white
        myLabel.backgroundColor = .systemYellow
        myLabel.textAlignment = .center
        myLabel.layer.cornerRadius = 5
        myLabel.clipsToBounds = true
        return myLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        [myImageView, titleLabel, priceLabel, deleteButton, bstLabel].forEach{addSubview($0)}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        myImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, size: .init(width: contentView.frame.width/1.7, height: 0))
        deleteButton.anchor(top: contentView.topAnchor, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 10))
        bstLabel.anchor(top: deleteButton.bottomAnchor, leading: myImageView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30), size: .init(width: 0, height: 40))
        titleLabel.anchor(top: bstLabel.bottomAnchor, leading: myImageView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
        priceLabel.anchor(top: nil, leading: myImageView.trailingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
    }
    
    public func configure(title: String, price: Int64, image: Data, bst: String){
        titleLabel.text = title
        titleLabel.font = titleLabel.font.withSize(15)
        
        priceLabel.text = "$\(price)"
        priceLabel.font = priceLabel.font.withSize(20)
        
        myImageView.image = UIImage(data: image)
        
        if bst == "Trading"{
            bstLabel.backgroundColor = .systemRed
        } else if bst == "Buying" {
            bstLabel.backgroundColor = .systemGreen
        } else {
            bstLabel.backgroundColor = .systemYellow
        }
        bstLabel.text = bst
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        priceLabel.text = nil
        myImageView.image = UIImage(systemName: "photo")
        bstLabel.text = "Selling"
    }
}


