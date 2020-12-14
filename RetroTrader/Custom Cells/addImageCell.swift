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
        imgView.layer.cornerRadius = 5
        imgView.image = UIImage()
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = .systemGray
        imgView.clipsToBounds = true
        return imgView
    }()
     
     override init(frame: CGRect) {
         super.init(frame: frame)

         [addImageView].forEach{addSubview($0)}
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         
         addImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
     }
     
    public func configure(image: Data){
        addImageView.image = UIImage(data: image)
    }
     
     override func prepareForReuse() {
         super.prepareForReuse()
         addImageView.image = UIImage()
     }
}
