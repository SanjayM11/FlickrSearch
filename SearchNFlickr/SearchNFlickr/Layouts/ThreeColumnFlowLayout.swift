//
//  ThreeColumnFlowLayout.swift
//  SearchNFlickr
//
//  Created by Sanjay Mohnani on 09/01/19.
//  Copyright © 2019 Sanjay Mohnani. All rights reserved.
//

import Foundation
import UIKit

class ThreeColumnFlowLayout:UICollectionViewFlowLayout{
    private var layoutMap = [IndexPath : UICollectionViewLayoutAttributes]()
    private var contentSize = CGSize(width:0, height:0)
    
    private var totalColumns = 0
    private(set) var totalItemsInSection = 0
    private var interItemsSpacing: CGFloat = 8
    private var itemsSize: CGSize!
    private let kItemHeightAspect: CGFloat  = 2
    
    private var columnsXoffset: [CGFloat]!
    private var columnsYoffset:[CGFloat]!
    
    var contentInsets: UIEdgeInsets {
        return collectionView!.contentInset
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.totalColumns = 3
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributesArray = [UICollectionViewLayoutAttributes]()
        for (_, layoutAttributes) in layoutMap {
            if rect.intersects(layoutAttributes.frame) {
                layoutAttributesArray.append(layoutAttributes)
            }
        }
        return layoutAttributesArray
    }
    
    func columnIndexForItemAt(indexPath: IndexPath) -> Int {
        let columnIndex = indexPath.item % totalColumns
        return columnIndex
    }
    
    func calculateItemFrame(indexPath: IndexPath, columnIndex: Int, columnYoffset: CGFloat) -> CGRect {
            return CGRect(x: columnsXoffset[columnIndex], y: columnYoffset, width: itemsSize.width, height: itemsSize.height)
    }

    func calculateItemsSize() {
        let contentWidthWithoutIndents = collectionView!.bounds.width - contentInsets.left - contentInsets.right
        let itemWidth = (contentWidthWithoutIndents - (CGFloat(totalColumns) - 1) * interItemsSpacing) / CGFloat(totalColumns)
        let itemHeight = itemWidth * kItemHeightAspect
        itemsSize = CGSize(width: itemWidth, height: itemHeight)
        
        columnsXoffset = []
        
        for columnIndex in 0...(totalColumns - 1) {
            columnsXoffset.append(CGFloat(columnIndex) * (itemsSize.width + interItemsSpacing))
        }
    }
    
    override func prepare() {
        layoutMap.removeAll()
        columnsYoffset = Array(repeating: 0, count: totalColumns)
        
        totalItemsInSection = collectionView!.numberOfItems(inSection: 0)
        
        if totalItemsInSection > 0 && totalColumns > 0 {
            self.calculateItemsSize()
            var itemIndex = 0
            var contentSizeHeight: CGFloat = 0
            
            while itemIndex < totalItemsInSection {
                let indexPath = IndexPath(item: itemIndex, section: 0)
                let columnIndex = self.columnIndexForItemAt(indexPath: indexPath)
                
                let attributeRect = calculateItemFrame(indexPath: indexPath, columnIndex: columnIndex, columnYoffset: columnsYoffset[columnIndex])
                let targetLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
                targetLayoutAttributes.frame = attributeRect
                
                contentSizeHeight = max(attributeRect.maxY, contentSizeHeight)
                columnsYoffset[columnIndex] = attributeRect.maxY + interItemsSpacing
                layoutMap[indexPath] = targetLayoutAttributes
                
                itemIndex += 1
            }
            contentSize = CGSize(width: collectionView!.bounds.width - contentInsets.left - contentInsets.right,
                                  height: contentSizeHeight)
        }
    }
}
