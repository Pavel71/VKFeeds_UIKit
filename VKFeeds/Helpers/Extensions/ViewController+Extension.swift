//
//  ViewController+Extension.swift
//  VKFeeds
//
//  Created by PavelM on 17/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

extension UIViewController {
  static func loadFromNib() -> Self {
    func instantiateFromNib<T: UIViewController>() -> T {
      return T.init(nibName: String(describing: T.self), bundle: nil)
    }
    
    return instantiateFromNib()
  }
}
