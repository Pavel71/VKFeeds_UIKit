//
//  NewsFeedPresenter.swift
//  VKFeeds
//
//  Created by PavelM on 17/08/2019.
//  Copyright (c) 2019 PavelM. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
  
  weak var viewController: NewsFeedDisplayLogic?
  var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = NewsFeedLayoutCalculator()
  
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.dateFormat = "d MMM 'в' HH:mm"
    return dateFormatter
  }()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {

    switch response {

    case .presentNewsFeed(let feed, let revealPostIds):

      // Формтаируем данные
      let cells = feed.items.map { (feedItem) in
        cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealPostids: revealPostIds)
      }
      
      let footertitle = String.localizedStringWithFormat(NSLocalizedString("NewsFeed Cells Count", comment: ""), cells.count)
      let feedViewModel = FeedViewModel.init(cells: cells, footerTitle: footertitle)
      // Отправляем данные в Controller
      viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))

    case .presentUserFeed(let userFeed):
      let titleViewViewModel = UserFeedViewModel.init(imageString: userFeed.photo100)
      viewController?.displayData(viewModel: .displayTitleFeed(titleViewModel: titleViewViewModel))
      
    case .presentFooterLoader:
      viewController?.displayData(viewModel: .displayFooterLoader)
    }
    
  }
  
  
  private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group],revealPostids: [Int]) -> FeedViewModel.Cell {
    
    let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
    let photoAttachments = self.photoAttachments(feedItem: feedItem)
    
    let date = Date(timeIntervalSince1970: feedItem.date)
    let dateTitle = dateFormatter.string(from: date)
    
    let isFullSized = revealPostids.contains(feedItem.postId)
    
    // Вычесляем размеры и добавляем в Модель
    let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
    
    let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
    
    return FeedViewModel.Cell.init(
       postId: feedItem.postId,
       iconUrlString: profile.photo,
       name: profile.name,
       date: dateTitle,
       text: postText,
       likes: formattedCounter(feedItem.likes?.count),
       comments: formattedCounter(feedItem.comments?.count),
       shares: formattedCounter(feedItem.reposts?.count),
       views: formattedCounter(feedItem.views?.count),
       
       photoAttachments: photoAttachments,
       sizes: sizes
    )
  }
  
  private func formattedCounter(_ counter: Int?) -> String? {
    guard let counter = counter, counter > 0 else {return nil}
    var countrString = String(counter)
    if 4...6 ~= countrString.count {
      countrString = String(countrString.dropLast(3) + "K")
    } else if countrString.count > 6 {
      countrString = String(countrString.dropLast(6) + "M")
    }
    return countrString
  }
  
  private func profile(for sourceId: Int, profiles: [Profile], groups:[Group]) -> ProfileRepresentable {
    let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
    let normalSourceId  = sourceId >= 0 ? sourceId : -sourceId
    
    let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
      myProfileRepresentable.id == normalSourceId
    }
    
    
    return profileRepresentable!
  }
  
  private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
    
    guard let photos = feedItem.attachments?.compactMap({ (attachment) in
      attachment.photo
    }), let firstPhoto = photos.first else {
      return nil
    }
    
    return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBig, width: firstPhoto.width, height: firstPhoto.height)
  }
  
  private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
    
    guard let attachments = feedItem.attachments else {return []}
    
    return attachments.compactMap({ (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
      guard let photo = attachment.photo else {return nil}
      return FeedViewModel.FeedCellPhotoAttachment.init(
        photoUrlString: photo.srcBig,
        width: photo.width,
        height: photo.height)
    })
    
  }
  
}
