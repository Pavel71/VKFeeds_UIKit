//
//  GradientView.swift
//  VKFeeds
//
//  Created by PavelM on 26/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class GradientView: UIView {
  
  private var startColor: UIColor = .red
  private var endCOlor: UIColor = .yellow
  private  let gradienLayer = CAGradientLayer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpGradient()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradienLayer.frame = bounds
  }
  
  
  private func setUpGradient() {
    self.layer.addSublayer(gradienLayer)
    gradienLayer.colors = [startColor.cgColor, endCOlor.cgColor]
    gradienLayer.startPoint = CGPoint(x: 0, y: 0)
    gradienLayer.endPoint = CGPoint(x: 1, y: 1)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
