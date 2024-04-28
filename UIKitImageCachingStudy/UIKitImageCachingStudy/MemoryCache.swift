//
//  MemoryCache.swift
//  UIKitImageCachingStudy
//
//  Created by 윤동주 on 4/28/24.
//

import UIKit

class MemoryCache: Cacheable {
    
    static let shared = MemoryCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func loadImage(url: URL) -> UIImage? {
        let key = createKey(from: url)
        return cache.object(forKey: key as NSString)
    }
    
    func saveImage(image: UIImage, 
                   url: URL,
                   option: SaveOption) {
        
        // 디스크에만 저장하거나 저장을 안하는 경우엔 return
        if option == .onlyDisk || option == .none {
            return
        }
        
        let key = createKey(from: url) as NSString
        cache.setObject(image, forKey: key)
    }
}
