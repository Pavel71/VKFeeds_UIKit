//
//  FooterView.swift
//  VKFeeds
//
//  Created by PavelM on 26/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class FooterView: UIView {
  
  private var myLabel: UILabel = {
    
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    label.textAlignment = .center
    return label
  }()
  
  private var loader: UIActivityIndicatorView = {
    let l = UIActivityIndicatorView(style: .white)
    l.hidesWhenStopped = true
    return l
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let stackView = UIStackView(arrangedSubviews: [
      loader,
      myLabel
      ])
    myLabel.constrainHeight(constant: 50)
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.alignment = .center
    
    addSubview(stackView)
    stackView.fillSuperview()
    
  }
  
  
  func showLoader() {
    loader.startAnimating()
  }
  
  func setTitle(_ title: String) {
    loader.stopAnimating()
    myLabel.text = title
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
