//
//  AuthiticationService.swift
//  VKFeeds
//
//  Created by PavelM on 15/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
  
  func showController(_ viewController: UIViewController)
  func authServiceSignIn()
  func authServiceDidSignInError()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {

  
  private let appId = "7097833"
  private let vkSdk: VKSdk
  
  weak var delegate: AuthServiceDelegate?
  
  var token: String? {
    return VKSdk.accessToken()?.accessToken
  }
  
  var userId: String? {
    return VKSdk.accessToken()?.userId
  }
  
  override init() {
    vkSdk = VKSdk.initialize(withAppId: appId)
    super.init()
    vkSdk.register(self)
    vkSdk.uiDelegate = self
  }
  
  func wakeUpSession() {
    
    let scope = ["wall, friends"] // Ключи доступа к ВК
    
    VKSdk.wakeUpSession(scope) {[delegate] (state, error) in
      if state == VKAuthorizationState.authorized {
        delegate?.authServiceSignIn()
        print("VKAuthorizationState.authorized")
      } else if state == VKAuthorizationState.initialized {
        print("VKAuthorizationState.initialized")
        VKSdk.authorize(scope)
      } else {
        print("auth problems, \(state)")
        delegate?.authServiceDidSignInError()
      }
    }
  }
  
  // MARK: VKSdk Delegate
  
  // Авторизация завершенна Можно переслать на новый Экран
  func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {

    if result.token != nil {
      self.delegate?.authServiceSignIn()
    }
    print(#function)
  }
  
  func vkSdkUserAuthorizationFailed() {
    print(#function)
  }
  
  // MARK: VKSdk UIDelegate
  // Покажи контроллер регистрации
  func vkSdkShouldPresent(_ controller: UIViewController!) {
    print(#function)
    delegate?.showController(controller)

  }
  
  func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    print(#function)
  }
  
}
