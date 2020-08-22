//
//  NewsFeedModels.swift
//  VKFeeds
//
//  Created by PavelM on 17/08/2019.
//  Copyright (c) 2019 PavelM. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    // Передача данных от контроллера к интерактору!
    struct Request {
      enum RequestType {
        case getNewsFeed
        case revealPostId(postId: Int)
        case getUser
        case getNextBach
        
      }
      
    }
    
    // Передача данных от Интерактора в презентер!
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedResponse, revealedPostIds: [Int])
        case presentUserFeed(userFeed: UserResponse)
        case presentFooterLoader
      }
    }
    
    struct ViewModel {
      enum ViewModelData {
    
        case displayNewsFeed(feedViewModel: FeedViewModel)
        case displayTitleFeed(titleViewModel: UserFeedViewModel)
        case displayFooterLoader
      }
    }
    
  }
  
}

// User

struct UserFeedViewModel: TitleViewViewModel {
  var imageString: String?
}

// Post

struct FeedViewModel {
  
  struct Cell: FeedCellViewModel {
    
    var postId: Int
    
    var iconUrlString: String
    var name: String
    var date: String
    var text: String?
    var likes: String?
    var comments: String?
    var shares: String?
    var views: String?
    
    var photoAttachments: [FeedCellPhotoAttachementViewModelable]
    var sizes: FeedCellSizeable
    
  }
  
  struct FeedCellPhotoAttachment: FeedCellPhotoAttachementViewModelable {

    var photoUrlString: String?
    var width: Int
    var height: Int
  }
  
  let cells:[Cell]
  let footerTitle: String?
  
}


