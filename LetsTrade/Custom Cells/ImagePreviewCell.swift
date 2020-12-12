//
//  TestCell.swift
//  LetsTrade
//
//  Created by Gary Naz on 12/6/20.
//

import Foundation
import UIKit

class imagePreviewCell: UICollectionViewCell {
    
   static let cellId = "ImagePreviewCellId"
    
    private let myImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
    
        [myImageView].forEach{addSubview($0)}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
    }
    
    public func configure(image: Data){
        myImageView.image = UIImage(data: image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = UIImage(systemName: "house")
    }
}
