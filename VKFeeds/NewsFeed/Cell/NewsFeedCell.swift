//
//  NewsFeedCell.swift
//  VKFeeds
//
//  Created by PavelM on 17/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


// Основной протокл на который мы подпишим модель с данными! Которуюу должна получать эта ячейка

protocol FeedCellViewModel {
  
  var iconUrlString: String {get}
  
  var name: String {get}
  var date: String {get}
  var text: String? {get}
  var likes: String? {get}
  var comments: String? {get}
  var shares: String? {get}
  var views: String? {get}
  
  
  var photoAttachments: [FeedCellPhotoAttachementViewModelable] {get}
  var sizes: FeedCellSizeable { get }
  
}

// Расширения для нашей ячейки!
protocol FeedCellPhotoAttachementViewModelable {
  
  var photoUrlString: String? {get}
  var width: Int {get}
  var height: Int {get}
  
}

protocol FeedCellSizeable {
  
  var postLabelFrame: CGRect {get}
  var attachmentFrame: CGRect {get}
  var bottomViewFrame: CGRect {get}
  var totalHeight: CGFloat {get}
  var moreTextButtonFrame: CGRect {get}
}


class NewsFeedCell: UITableViewCell {
  
  static let cellID = "cellID"

  @IBOutlet weak var cardView: UIView!
  
  // TopView
  @IBOutlet weak var iconImageView: WebImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  


  //  @IBOutlet weak var textlabel: UILabel!
  @IBOutlet weak var postImageView: WebImageView!
  @IBOutlet weak var postLabel: UILabel!
  
  // Bottom View
  
  
  @IBOutlet weak var bottomView: UIView!
  
  @IBOutlet weak var likesLabel: UILabel!
  @IBOutlet weak var commentsLabel: UILabel!
  @IBOutlet weak var sharesLabel: UILabel!
  @IBOutlet weak var eyeslabel: UILabel!
  
  
  override func prepareForReuse() {
    iconImageView.set(imageUrl: nil)
    postImageView.set(imageUrl: nil)
  }

  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
    iconImageView.clipsToBounds = true
    
    cardView.layer.cornerRadius = 10
    cardView.clipsToBounds = true
    
    backgroundColor = .clear
    selectionStyle = .none
  }
  
  
  func set(viewModel: FeedCellViewModel) {

    iconImageView.set(imageUrl: viewModel.iconUrlString)
    
    nameLabel.text = viewModel.name
    dateLabel.text = viewModel.date
    postLabel.text = viewModel.text

    
    likesLabel.text = viewModel.likes
    commentsLabel.text = viewModel.comments
    sharesLabel.text = viewModel.shares
    eyeslabel.text = viewModel.views
    
    postLabel.frame = viewModel.sizes.postLabelFrame
    postImageView.frame = viewModel.sizes.attachmentFrame
    bottomView.frame = viewModel.sizes.bottomViewFrame
    
//    if let photoAttachment = viewModel.photoAttachment {
//      postImageView.set(imageUrl: photoAttachment.photoUrlString)
//      postImageView.isHidden = false
//    } else {
//      postImageView.isHidden = true
//    }
    
    if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
      postImageView.set(imageUrl: photoAttachment.photoUrlString)
      postImageView.isHidden = false
    } else {
      postImageView.isHidden = true
    }
    
  }
  
  
}
