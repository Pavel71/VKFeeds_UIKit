//
//  NewsFeedInteractor.swift
//  VKFeeds
//
//  Created by PavelM on 17/08/2019.
//  Copyright (c) 2019 PavelM. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsfeedService?
  
//  private var revealedPostIds = [Int]()
//  private var feedResponse: FeedResponse?
  
  // Fetcher
//  private var fetcher: DataFetcher
  
  init(authService: AuthService) {
//    self.fetcher = NetworkDataFetcher(networking: NetworkService(authService: authService),authService: authService)
  }
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    
    switch request {

    case .getNewsFeed:
      service?.getFeed(completion: {[weak self] (revealedPostIds, feed) in
        self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
      })
    case .revealPostId(let postId):
      service?.revealPostIds(forPostId: postId, completion: { [weak self] (revealedPostIds, feed) in
        self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
      })
    case .getUser:
      service?.getUser(completion: { [weak self] (user) in
        self?.presenter?.presentData(response: .presentUserFeed(userFeed: user!))
      })

    case .getNextBach:
      
      self.presenter?.presentData(response: .presentFooterLoader)
      
      service?.getNextBatch(completion: {[weak self] (revealedPostIds, feed) in
        self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
      })
    }

    
    
  }

}
