//
//  WebImageView.swift
//  VKFeeds
//
//  Created by PavelM on 19/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
  
  private var currentUrlString: String?
  
  func set(imageUrl: String?) {
    currentUrlString = imageUrl
    guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
      self.image = nil
      return
    }
    
    // Если картинка лежи в Cahe то не загружаем ее
    if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
      self.image = UIImage(data: cachedResponse.data)
      return
    }
    
    let dataTask = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
      
      DispatchQueue.main.async {
        
        if let error = error {
          print(error)
        }
        
        if let data = data, let response = response {
          self?.handleLoadedImage(data: data, response: response)
        }
        
      }

    }
    dataTask.resume()
  }
  
  private func handleLoadedImage(data: Data, response: URLResponse) {
    guard let responseUrl = response.url else { return}
    
    let cachedResponse = CachedURLResponse(response: response, data: data)
    URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
    
    // Сверили сыссылки чтобы не подгружать лишний раз
    if responseUrl.absoluteString == currentUrlString {
      self.image = UIImage(data: data)
    }
  }
}
