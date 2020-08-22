//
//  RowLayout.swift
//  VKFeeds
//
//  Created by PavelM on 22/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import UIKit


protocol RowLayoutDelegate: class {
  
  func collectionView (_ collectionView: UICollectionView, photoAtIndexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
  
  weak var delegate: RowLayoutDelegate!
  
  static var numbersOfRows = 2
  fileprivate var cellPadding: CGFloat = 8
  
  fileprivate var cache = [UICollectionViewLayoutAttributes]()
  
  fileprivate var contentWidth: CGFloat = 0
  
  fileprivate var contentHeight: CGFloat {
    guard let collectionView = collectionView else {return 0}
    let insets = collectionView.contentInset
    
    return collectionView.bounds.height - (insets.left + insets.right)
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func prepare() {
    // При переиспользование нужно обновлять эти паоаметры
    contentWidth = 0
    cache = []
    guard cache.isEmpty, let collectionView = collectionView else {return}
    
    var photos = [CGSize]()
    
    for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
      photos.append(photoSize)
    }
    
    // Высота строки
    let superviewWidth = collectionView.frame.width
    guard var rowHeight = RowLayout.rowHeightCounter(superviewWidth: superviewWidth, photsArray: photos) else {return}
    rowHeight = rowHeight / CGFloat(RowLayout.numbersOfRows)
    
    //
    let photosRatios = photos.map{$0.height / $0.width}
    
    var yOffset = [CGFloat]()
    for row in 0 ..< RowLayout.numbersOfRows {
      yOffset.append(CGFloat(row) * rowHeight)
    }
    var xOffset = [CGFloat](repeating: 0, count: RowLayout.numbersOfRows)
    
    var row = 0
    
    // Создаем для каждой ячейки размер и фиксируем их положение
    for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
      
      let indexPath = IndexPath(item: item, section: 0)
      
      let ratio = photosRatios[indexPath.row]
      let width = rowHeight / ratio
      let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
      let insertFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
      
      let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attribute.frame = insertFrame
      cache.append(attribute)
      
      contentWidth = max(contentWidth,frame.maxX)
      xOffset[row] = xOffset[row] + width
      row = row < (RowLayout.numbersOfRows - 1) ? (row + 1) : 0
    
    }
    
  }
  
  // Высота ячейке считается по высоте картинки с самым маленьким соотношением сторон
  static func rowHeightCounter(superviewWidth: CGFloat,photsArray: [CGSize]) -> CGFloat? {
    var rowHeight: CGFloat
    
    let photoWidthMinRatio = photsArray.min { (first, second) -> Bool in
      (first.height / first.width) < (second.height / second.width)
    }
    guard let myPhotoWidthMinRatio = photoWidthMinRatio else {return nil}
  
    let difference = superviewWidth / myPhotoWidthMinRatio.width
    
    rowHeight = myPhotoWidthMinRatio.height * difference
    
    rowHeight = rowHeight * CGFloat(RowLayout.numbersOfRows)
    return rowHeight
  }
  
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attribute in cache {
      
      if attribute.frame.intersects(rect) {
        visibleLayoutAttributes.append(attribute)
      }
      
    }
    
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.row]
  }
}
