//
//  AppDelegate.swift
//  VKFeeds
//
//  Created by PavelM on 15/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {
 
  

  var window: UIWindow?
  var authService: AuthService!
  
  // Верни AppDelegate синглтоном
  static func shared() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
  

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    authService = AuthService()
    authService.delegate = self
    root()
    return true
  }
  
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    
    VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
    
    return true
  }
  
  func root() {
    // Пока для отладки сразу буду запускать рабочий контроллер
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    let authController = AuthVKController(authService: authService)
    
    
//     let newsFeedViewController = NewsFeedViewController(nibName: String(describing: NewsFeedViewController.self), bundle: nil, authService: authService)
    
    window?.rootViewController = authController
  }
  
  
  
  // MARK: AuthService Delegate
  
  func showController(_ viewController: UIViewController) {
    print(#function)
    // Подгрузи экран ВК Регистрации или авторизации
    window?.rootViewController?.present(viewController, animated: true, completion: nil)
  }
  
  // Когда регистрация прошла успешно
  func authServiceSignIn() {
    print(#function)
    // Передаем объект network Service
//    let netWorkService = NetworkService(authService: authService)
//    let feedViewController = FeedViewController(networkService: netWorkService)
    
    let newsFeedViewController = NewsFeedViewController(nibName: String(describing: NewsFeedViewController.self), bundle: nil,authService:authService )
    
    
    
    
    // Если что можно сделать UiNavigationController
    window?.rootViewController?.present(UINavigationController(rootViewController: newsFeedViewController), animated: true, completion: nil)
  }
  
  func authServiceDidSignInError() {
    print(#function)
  }

  


}

