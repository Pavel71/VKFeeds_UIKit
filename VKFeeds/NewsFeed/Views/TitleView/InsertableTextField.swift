//
//  InsertableTextField.swift
//  VKFeeds
//
//  Created by PavelM on 22/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

class InsertableTextField: UITextField {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    placeholder = "Поиск"
    font = UIFont.systemFont(ofSize: 14)
    borderStyle = .none
    layer.cornerRadius = 10
    clipsToBounds = true
    
    let image = UIImage(named: "search")
    leftView = UIImageView(image: image)
    leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
    leftViewMode = .always
  }
  
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 36, dy: 0)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 36, dy: 0)
  }
  
  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var rect = super.leftViewRect(forBounds: bounds)
    
    rect.origin.x += 12
    return rect
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
