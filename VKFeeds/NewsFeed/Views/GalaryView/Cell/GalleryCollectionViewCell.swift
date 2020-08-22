//
//  GalleryCollectionViewCell.swift
//  VKFeeds
//
//  Created by PavelM on 22/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
  
  static let cellId = "gallaryCellID"
  
  
  let imageView: WebImageView = {
    let iv = WebImageView()
    iv.contentMode = .scaleAspectFill
    iv.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
    return iv
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(imageView)
    imageView.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
  }

  override func prepareForReuse() {
    imageView.image = nil
  }
  
  func set(imageUrl: String?) {
    imageView.set(imageUrl: imageUrl)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    
    self.layer.shadowRadius = 3
    layer.shadowOpacity = 0.3
    layer.shadowOffset = CGSize(width: 2.5, height: 4)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    
  }
  
}
