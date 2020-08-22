//
//  NewsFeedCodeCell.swift
//  VKFeeds
//
//  Created by PavelM on 20/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit

class NewsFeedCodeCell: UITableViewCell {
  
  static let cellId = "CellId"
  
  let cardView: UIView = {
    let v = UIView()
    v.layer.cornerRadius = 10
    v.clipsToBounds = true
    v.backgroundColor = .white
    return v
  }()
  
  // TopView
  var topView: UIStackView!
  // BottomView
  var bottomStackView: UIView!
  
  let imageIconView: WebImageView = {
    let iv = WebImageView()
    iv.backgroundColor = .white
   
    return iv
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Some Title"
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  let dateLabel: UILabel = {
    let label = UILabel()
    label.text = "Some Date"
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  // More TextButton
  
  let moreTextButton: UIButton = {
    let button = UIButton(type: .system)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    button.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
    button.contentVerticalAlignment = .center
    button.contentHorizontalAlignment = .left
//    button.addTarget(self, action: #selector(didTapMoreTextButton), for: .touchUpInside)
    
    button.setTitle("Показать полностью ...", for: .normal)
    return button
  }()
  
  // PostSLabel
  
//  let postsLabel: UILabel =  {
//    let label = UILabel()
//    label.text = "Big Postsssss mmasmmdsmdm masmdkaksdkasd mmskamdkasdm ,lsad,la alsdmalsdm"
//    label.numberOfLines = 0
//    return label
//  }()
  
  let postsLabel: UITextView = {
    let textView = UITextView()
    textView.font = Constants.postLabelFont
    textView.isScrollEnabled = false
    textView.isSelectable = true
    textView.isUserInteractionEnabled = true
    textView.isEditable = false
    
    let padding = textView.textContainer.lineFragmentPadding
    textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
    
    textView.dataDetectorTypes = UIDataDetectorTypes.all
    return textView
  }()
  
  // PostImageView
  
  let postImageView: WebImageView = {
    let iv = WebImageView()
    
    return iv
  }()
  
  // GalleryCollectionView
  let galleryCollectionView = GalleryCollectionView()
  
  // BottomView
  
  let likesLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.lineBreakMode = .byClipping
    return label
  }()
  let commentsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.lineBreakMode = .byClipping
    return label
  }()
  let sharesLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.lineBreakMode = .byClipping
    return label
  }()
  let viewsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .right
    label.lineBreakMode = .byClipping
    return label
  }()
  

  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .clear
    self.selectionStyle = .none
    
    setUPCardView()
    setUpTopView()
    
    setUPostsLabelProstImageViewAndMoreTextButtonAndGalleryCollectionView()
    setUPBottomView()
  }
  
  override func prepareForReuse() {
    imageIconView.set(imageUrl: nil)
    postImageView.set(imageUrl: nil)
  }
  
  private func setUPCardView() {
    addSubview(cardView)
    cardView.fillSuperview(padding: .init(top: 5, left: 8, bottom: 5, right: 8))
  }
  
  private func setUpTopView() {
    
    let topLabelVerticalStackView = UIStackView(arrangedSubviews: [
      nameLabel,
      dateLabel
      ])
    topLabelVerticalStackView.axis = .vertical
    topLabelVerticalStackView.distribution = .fillEqually
    
    let topStackView = UIStackView(arrangedSubviews: [
      imageIconView,topLabelVerticalStackView
      ])
    imageIconView.constrainWidth(constant: Constants.topViewHeight)
    imageIconView.constrainHeight(constant: Constants.topViewHeight)
    imageIconView.layer.cornerRadius = Constants.topViewHeight / 2
    imageIconView.clipsToBounds = true
    
    topStackView.spacing = 5
   
    topView = topStackView
    
    cardView.addSubview(topView)
    topView.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor,padding: .init(top: 5, left: 8, bottom: 0, right: 8))
  }
  
  private func setUPostsLabelProstImageViewAndMoreTextButtonAndGalleryCollectionView() {
    cardView.addSubview(postsLabel)
    cardView.addSubview(postImageView)
    cardView.addSubview(galleryCollectionView)
    cardView.addSubview(moreTextButton)
    moreTextButton.addTarget(self, action: #selector(didTapMoreTextButton), for: .touchUpInside)
  }
  
  private func setUPBottomView() {
    let likeImageView = UIImageView(image: #imageLiteral(resourceName: "like"))
    let commentImageView = UIImageView(image: #imageLiteral(resourceName: "comment"))
    let shareImageView = UIImageView(image: #imageLiteral(resourceName: "share"))
    let viewsImageView = UIImageView(image: #imageLiteral(resourceName: "eye"))
    
    let viewsStackView = createBottomSubViewsStackView(imageView: viewsImageView, label: viewsLabel)
    
    
    let containerView = UIView()
    
    // Привязываем к правой границе
    containerView.addSubview(viewsStackView)
    viewsStackView.anchor(top: containerView.topAnchor, leading: nil, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 5, right: 5))
   
    
    let bottomSV = UIStackView(arrangedSubviews: [
      createBottomSubViewsStackView(imageView: likeImageView, label: likesLabel),
      createBottomSubViewsStackView(imageView: commentImageView, label: commentsLabel),
      createBottomSubViewsStackView(imageView: shareImageView, label: sharesLabel),
      ])
    
    bottomSV.distribution = .fillEqually
    bottomSV.spacing = 5
    
    // Привязываем к левой границе
    containerView.addSubview(bottomSV)
    bottomSV.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: nil ,padding: .init(top: 0, left: 5, bottom: 5, right: 0))
    
    bottomStackView = containerView
    
    cardView.addSubview(bottomStackView)
    bottomStackView.anchor(top: nil, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor)
    bottomStackView.constrainHeight(constant: Constants.bottomViewheight)
    
    
  }
  
  private func createBottomSubViewsStackView(imageView: UIImageView, label: UILabel) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: [
      imageView,label
      ])
    
    // Зададим Константы
    label.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.bottomLabelWidth).isActive = true
    imageView.constrainWidth(constant: Constants.bottomImageViewWidth)
    
    stackView.distribution = .fill
    stackView.spacing = 5
    return stackView
  }
  
  // MARK: More Text Button
  var didTapMoreTextButtonCLouser: ((NewsFeedCodeCell) -> Void)?
  @objc func didTapMoreTextButton() {
    didTapMoreTextButtonCLouser!(self)
  }
  
  func set(viewModel: FeedCellViewModel) {
    
    imageIconView.set(imageUrl: viewModel.iconUrlString)
    
    nameLabel.text = viewModel.name
    dateLabel.text = viewModel.date
    postsLabel.text = viewModel.text

    likesLabel.text = viewModel.likes
    commentsLabel.text = viewModel.comments
    sharesLabel.text = viewModel.shares
    viewsLabel.text = viewModel.views

    postsLabel.frame = viewModel.sizes.postLabelFrame
  
    moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
//    bottomView.frame = viewModel.sizes.bottomViewFrame
//
//    if let photoAttachment = viewModel.photoAttachment {
//      postImageView.set(imageUrl: photoAttachment.photoUrlString)
//      postImageView.isHidden = false
//    } else {
//      postImageView.isHidden = true
//    }
    
    // Вообщем если картинка 1 то размести ее если несколько то запили galleryCollectionView
    
    if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
      // 1 Фотография
      postImageView.set(imageUrl: photoAttachment.photoUrlString)
      postImageView.isHidden = false
      galleryCollectionView.isHidden = true
      
      postImageView.frame = viewModel.sizes.attachmentFrame
    } else if viewModel.photoAttachments.count > 1 {
      // Фотографий больше 1
      galleryCollectionView.frame = viewModel.sizes.attachmentFrame
      postImageView.isHidden = true
      galleryCollectionView.isHidden = false
      galleryCollectionView.set(photos: viewModel.photoAttachments)
    } else {
       // Нет фотографий
       postImageView.isHidden = true
       galleryCollectionView.isHidden = true
    }
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
