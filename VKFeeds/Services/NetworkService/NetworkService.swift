//
//  NetworkService.swift
//  VKFeeds
//
//  Created by PavelM on 16/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import Foundation

// Worker Protocol
protocol Networking {
  
  func reguest(path: String, params: [String: String], completion: @escaping(Data?,Error?) -> Void)
}

// Worker
final class NetworkService: Networking {

//  https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.101
  
  let authService: AuthService
  
  init(authService: AuthService) {
    self.authService = authService
  }

  
  // MARK: Networkin Delegate
  
  func reguest(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
    
    guard let token = authService.token else {return}
    
    var allParams = params
    allParams["access_token"] = token
    allParams["v"] = API.version
    
    let url = self.url(from: path, params: allParams)
    
    
    // Этот запрос работает нормально
//    let userUrlRequest = "https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=\(token)&v=5.101"
    
    let request = URLRequest(url: url)
    let task = createDataTask(from: request, completion: completion)
    task.resume()
    
    print(url)
  }
  
  // Добавим изменяемые параметры в функцию!
  private func url(from path: String, params: [String: String]) -> URL {
    
    var components = URLComponents()
    
    components.scheme = API.scheme
    components.host = API.host
    components.path = path
    components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
    
    return components.url!
  }
  
  private func createDataTask(from request: URLRequest,completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
    
    return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
      DispatchQueue.main.async {
        completion(data, error)
      }
    })
  }
  
}
