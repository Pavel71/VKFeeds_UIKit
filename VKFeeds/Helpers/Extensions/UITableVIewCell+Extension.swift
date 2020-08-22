//
//  UITableVIewCell+Extension.swift
//  VKFeeds
//
//  Created by PavelM on 17/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


extension UITableViewCell {
  
  static func loadFromNib() -> UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }
}
