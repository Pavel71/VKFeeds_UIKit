//
//  FeedViewController.swift
//  VKFeeds
//
//  Created by PavelM on 15/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
  
  private let networkService: NetworkService
  private var networkDataFetcher: NetworkDataFetcher
  
  init(networkService: NetworkService) {
    
    self.networkService = networkService
    self.networkDataFetcher = NetworkDataFetcher(networking: networkService,authService:networkService.authService )
    
    super.init(nibName: nil, bundle: nil)
    
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchData()
    view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
  }
  
  private func fetchData() {
    
//    networkDataFetcher.getFeed { (feedResponse) in
//      guard let feedResponse = feedResponse else {return}
//      print(feedResponse.items[0])
//    }
//    
  }
  
  
//  private func fetchData() {
//
//    let params = ["filters": "post,photo"]
//
//    networkService.reguest(path: API.newsFeed, params: params) { (data, error) in
//      if let error = error {
//        print("Error newsFedd request",error)
//
//      }
//
//      let decoder = JSONDecoder()
//      decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//      guard let data = data else {return}
////      let json = try? JSONSerialization.jsonObject(with: data, options: [])
////      print(json)
//
//      let response = try? decoder.decode(FeedResponsWrapped.self, from: data)
//      print(response)
//
//      response?.response.items.forEach({ (item) in
//        print(item.text)
//      })
//
//    }
//  }
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
