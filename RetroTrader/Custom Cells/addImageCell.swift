//
//  addImageCell.swift
//  RetroTrader
//
//  Created by Gary Naz on 12/9/20.
//

import Foundation
import UIKit


class addImageCell : UICollectionViewCell {
    static let cellId = "addImageCellId"
     
    private let addImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        return imgView
    }()
     
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(addImageView)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
        contentView.backgroundColor = .systemGray
        contentView.contentMode = .scaleAspectFill
        contentView.layer.cornerRadius = 5
        addImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
     }
     
    public func configure(image: Data){
        addImageView.image = UIImage(data: image)
    }
     
     override func prepareForReuse() {
         super.prepareForReuse()
         addImageView.image = UIImage()
     }
}
