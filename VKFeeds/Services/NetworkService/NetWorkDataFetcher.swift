//
//  NetWorkDataFetcher.swift
//  VKFeeds
//
//  Created by PavelM on 17/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import Foundation

// Worker Protocol
protocol DataFetcher {
  func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
  func getUser(response: @escaping (UserResponse?) -> Void)
}

// Worker
struct NetworkDataFetcher: DataFetcher {

  

  let authService: AuthService
  let networking: Networking
  
  init(networking: Networking,authService: AuthService) {
    self.networking = networking
    self.authService = authService
  }
  
  func getUser(response: @escaping (UserResponse?) -> Void) {
    
    guard let userId = authService.userId else {return}
    let params = ["fields": "photo_100", "user_ids": userId]
    networking.reguest(path: API.user, params: params) { (data, error) in
      if let error = error {
        print("GeetUser error",error)
        response(nil)
      }
      let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
      response(decoded?.response.first)
    }
    
    
  }
  
  func getFeed(nextBatchFrom: String?,response: @escaping (FeedResponse?) -> Void) {
    var params = ["filters": "post,photo"]
    params["start_from"] = nextBatchFrom // Этот параметр отвечает за загрузку старых постов по времени
    
    networking.reguest(path: API.newsFeed, params: params) { (data, error) in
      if let error = error {
        print("GeetFeed error",error)
        response(nil)
      }
      let decoded = self.decodeJSON(type: FeedResponsWrapped.self, from: data)
      response(decoded?.response)
    }
  }

  
  private func decodeJSON<T: Decodable>(type: T.Type,from: Data?) -> T? {
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    guard let data = from,  let response = try? decoder.decode(type, from: data) else {return nil}
    
    return response
  }
  
}
