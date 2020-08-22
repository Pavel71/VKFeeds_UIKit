//
//  NewsFeedCellLayoutCalculator.swift
//  VKFeeds
//
//  Created by PavelM on 19/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

// Protocol
protocol FeedCellLayoutCalculatorProtocol {
  func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachementViewModelable],isFullSizedPost: Bool) -> FeedCellSizeable
}

// Worker
final class NewsFeedLayoutCalculator: FeedCellLayoutCalculatorProtocol {
  
  private let screenWidth: CGFloat
  
  init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
    self.screenWidth = screenWidth
  }
  
  func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachementViewModelable], isFullSizedPost: Bool) -> FeedCellSizeable {
    
    var showMoreTextButton = false
    
    let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
    
    
    // MARK: - Работа с PostLabelFrame
    
    var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInserts.left, y: Constants.postLabelInserts.top), size: .zero)
    
    // Проверяем пришел ли текст вообще
    if let text = postText, !text.isEmpty {
      let width = cardViewWidth - Constants.postLabelInserts.left - Constants.postLabelInserts.right
      var height = text.height(width: width,font: Constants.postLabelFont)
      
      
      let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
      
      if !isFullSizedPost && height > limitHeight {
        height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
        showMoreTextButton = true
      }
      
      postLabelFrame.size = .init(width: width, height: height)
    }
    
    // MARK: - Рфбота с moreTextButtonFrame
    var moreTextButtonSize = CGSize.zero
    if showMoreTextButton {
      moreTextButtonSize = Constants.moreTextButtonSize
    }
    // В конце Label если ее размещаем
    let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
    
    let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
    // MARK: - Работа с AttachmentFrame
    
    let attachmentTop  = postLabelFrame.size == .zero ? Constants.postLabelInserts.top : moreTextButtonFrame.maxY + Constants.postLabelInserts.bottom
    
    var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: .zero)
    
//    if let attachment = photoAttachment {
//      let photoHeight: Float = Float(attachment.height)
//      let photoWidth: Float = Float(attachment.width)
//      let ratio = CGFloat(photoHeight / photoWidth)
//
//      attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
//    }
    if let attachment = photoAttachments.first {
      let photoHeight: Float = Float(attachment.height)
      let photoWidth: Float = Float(attachment.width)
      let ratio = CGFloat(photoHeight / photoWidth)
      if photoAttachments.count == 1 {
        attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
      }  else if photoAttachments.count > 1 {
//        print("More than one photo")
//        attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        
        var photos = [CGSize]()
        for photo in photoAttachments {
          let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
          photos.append(photoSize)
        }
        let rowHeight = RowLayout.rowHeightCounter(superviewWidth: cardViewWidth, photsArray: photos)
        attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
      }
    }
    
    // MARK: BottomViewFrame
    
    let bottomYTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
    
    let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomYTop), size: CGSize(width: cardViewWidth, height: Constants.bottomViewheight))
    
    // MARK: TotalVieheight
    let totalHeigh = bottomViewFrame.maxY + Constants.cardInsets.bottom
    
    
    return Sizes(postLabelFrame: postLabelFrame, moreTextButtonFrame: moreTextButtonFrame, attachmentFrame: attachmentFrame, bottomViewFrame: bottomViewFrame, totalHeight: totalHeigh)

  }
  
}

struct Sizes: FeedCellSizeable {

  var postLabelFrame: CGRect
  var moreTextButtonFrame: CGRect
  var attachmentFrame: CGRect
  
  var bottomViewFrame: CGRect
  var totalHeight: CGFloat
  
}



