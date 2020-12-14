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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.cgColor
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        [myImageView, titleLabel, priceLabel, deleteButton].forEach{addSubview($0)}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        deleteButton.anchor(top: contentView.topAnchor, leading: myImageView.trailingAnchor, bottom: titleLabel.topAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 80, bottom: 20, right: 0))
        myImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 120))
        titleLabel.anchor(top: contentView.topAnchor, leading: myImageView.trailingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 60, left: 0, bottom: 90, right: 0))
        priceLabel.anchor(top: contentView.topAnchor, leading: myImageView.trailingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 100, left: 0, bottom: 20, right: 0))
    }
    
    public func configure(title: String, price: Int64, image: Data){
        titleLabel.text = title
        titleLabel.font = titleLabel.font.withSize(15)
        
        priceLabel.text = "$\(price)"
        priceLabel.font = priceLabel.font.withSize(20)
        
        myImageView.image = UIImage(data: image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        priceLabel.text = nil
        myImageView.image = UIImage(systemName: "photo")
    }
}


