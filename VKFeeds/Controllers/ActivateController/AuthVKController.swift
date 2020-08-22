//
//  ViewController.swift
//  VKFeeds
//
//  Created by PavelM on 15/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

class AuthVKController: UIViewController {
  
 
  
  let authVkButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("Авторизоватся через ВК", for: .normal)
    b.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    b.setTitleColor(#colorLiteral(red: 0.2980392157, green: 0.4588235294, blue: 0.6392156863, alpha: 1), for: .normal)
    b.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
    b.addTarget(self, action: #selector(didTapAuthButton), for: .touchUpInside)
    b.layer.cornerRadius = 10
    b.contentEdgeInsets  = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    return b
  }()
  
  private var authService: AuthService
  
  init(authService: AuthService) {
    self.authService = authService
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    setUpAuthButton()
  }
  
  private func setUpAuthButton() {
    view.addSubview(authVkButton)
    authVkButton.centerInSuperview(size: .init(width: 0, height: 100))
  }
  
  
  @objc func didTapAuthButton() {
    print("Push Button")
    authService.wakeUpSession()
  }

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

