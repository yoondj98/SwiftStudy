//
//  UICollectionView+.swift
//  CollectionViewStudy
//
//  Created by 윤동주 on 5/1/24.
//

import UIKit

extension UICollectionView {
    
    /// 주어진 kind를 기준으로 indexPath에 있는 곳으로 이동
    func scrollToSupplementaryView(ofKind kind: String, at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        self.layoutIfNeeded();
        if let layoutAttributes =  self.layoutAttributesForSupplementaryElement(ofKind: kind, at: indexPath) {
            let viewOrigin = CGPoint(x: layoutAttributes.frame.origin.x, y: layoutAttributes.frame.origin.y);
            var offset : CGPoint = self.contentOffset;
            
            switch(scrollPosition) {
            case UICollectionView.ScrollPosition.top:
                offset.y = viewOrigin.y - self.contentInset.top
                
            case UICollectionView.ScrollPosition.left:
                offset.x = viewOrigin.x - self.contentInset.left
                
            case UICollectionView.ScrollPosition.right:
                offset.x = (viewOrigin.x - self.contentInset.left) - (self.frame.size.width - layoutAttributes.frame.size.width)
                
            case UICollectionView.ScrollPosition.bottom:
                offset.y = (viewOrigin.y - self.contentInset.top) - (self.frame.size.height - layoutAttributes.frame.size.height)
                
            case UICollectionView.ScrollPosition.centeredVertically:
                offset.y = (viewOrigin.y - self.contentInset.top) -  (self.frame.size.height / 2 - layoutAttributes.frame.size.height / 2)
                
            case UICollectionView.ScrollPosition.centeredHorizontally:
                offset.x = (viewOrigin.x - self.contentInset.left) -  (self.frame.size.width / 2 - layoutAttributes.frame.size.width / 2)
            default:
                break
            }
            self.scrollRectToVisible(CGRect(origin: offset, size: self.frame.size), animated: animated)
        }
    }
}
