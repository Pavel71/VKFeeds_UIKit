//
//  GalleryCollectionView.swift
//  VKFeeds
//
//  Created by PavelM on 22/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


class GalleryCollectionView: UICollectionView {
  
  var photos = [FeedCellPhotoAttachementViewModelable]()
  
  init() {
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .horizontal
    let rowLayout = RowLayout()
    super.init(frame: .zero, collectionViewLayout: rowLayout)
    
    rowLayout.delegate = self
    delegate = self
    dataSource = self
    backgroundColor = .white
    
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
    
    self.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.cellId)
  }
  
  func set(photos: [FeedCellPhotoAttachementViewModelable]) {
    self.photos = photos
    contentOffset = CGPoint.zero
    DispatchQueue.main.async {
      self.reloadData()
    }
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.cellId, for: indexPath) as! GalleryCollectionViewCell
    let photo = photos[indexPath.row]
    cell.set(imageUrl: photo.photoUrlString)
    return cell
  }
  
  
}

extension GalleryCollectionView: RowLayoutDelegate {
  
  func collectionView(_ collectionView: UICollectionView, photoAtIndexPath: IndexPath) -> CGSize {
    let width = photos[photoAtIndexPath.row].width
    let height = photos[photoAtIndexPath.row].height
    
    return CGSize(width: width, height: height)
  }
  
  
}
