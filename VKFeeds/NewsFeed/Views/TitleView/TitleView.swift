//
//  TitleView.swift
//  VKFeeds
//
//  Created by PavelM on 22/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


protocol TitleViewViewModel {
  var imageString: String? {get}
}


class TitleView: UIView {
  
  let textFIeld = InsertableTextField()
  
  let avatarImageView: WebImageView = {
    let iv = WebImageView()
    iv.backgroundColor = .orange
    return iv
  }()
  
  static let imageHeight: CGFloat = 30
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    let stackView = UIStackView(arrangedSubviews: [
      textFIeld,avatarImageView
      ])
    stackView.spacing = 10
    avatarImageView.constrainWidth(constant: TitleView.imageHeight)
    avatarImageView.constrainHeight(constant: TitleView.imageHeight)
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    
    
    
  }
  
  func set(titleViewViewModel: TitleViewViewModel) {
    
    avatarImageView.set(imageUrl: titleViewViewModel.imageString)
  }
  
  // я так понял чтобы нормальо располагалаась в рамках других View TableView
  override var intrinsicContentSize: CGSize {
    return UIView.layoutFittingExpandedSize
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = TitleView.imageHeight / 2
    
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
