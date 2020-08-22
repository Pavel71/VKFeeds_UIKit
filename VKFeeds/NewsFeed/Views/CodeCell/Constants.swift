//
//  Constants.swift
//  VKFeeds
//
//  Created by PavelM on 21/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


struct Constants {
  
  static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
  static let topViewHeight: CGFloat = 48
  
  static let postLabelFont = UIFont.systemFont(ofSize: 15)
  static let postLabelInserts = UIEdgeInsets(top: 8 + Constants.topViewHeight, left: 8, bottom: 8, right: 8)
  
  // Bottom View
  static let bottomViewheight: CGFloat = 40
  static let bottomImageViewWidth: CGFloat = 24
  static let bottomLabelWidth: CGFloat = 48
  
  // More Text Button
  
  
  static let minifiedPostLimitLines: CGFloat = 8
  static let minifiedPostLines: CGFloat = 6
  static let moreTextButtonSize = CGSize(width: 170, height: 30)
  static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
}
