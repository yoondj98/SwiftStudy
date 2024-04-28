//
//  ImageCache.swift
//  UIKitImageCachingStudy
//
//  Created by 윤동주 on 4/28/24.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private var memoryCache = MemoryCache.shared
    private var diskCache = DisckCache.shared
    
    private init() {}
    
    func load(url: URL?,
              saveOption: SaveOption,
              completion: @escaping (UIImage?) -> Void){
        guard let url else {
            completion(nil)
            return
        }
        
        let startTime = CFAbsoluteTimeGetCurrent()
        
        // Memory Cache에 존재하는지 확인하고 있으면 이미지 반환
        if let cachedImage = self.memoryCache.loadImage(url: url) {
            let timeTaken = CFAbsoluteTimeGetCurrent() - startTime
            print("Time taken from Memory Cache: \(String(format: "%.7f", timeTaken)) seconds")
            completion(cachedImage)
            return
        }
        DispatchQueue.global().async {
            let diskStartTime = CFAbsoluteTimeGetCurrent()
            
            // Memory Cache에 없다면
            // Disk Cache에 존재하는지 확인하고
            // 있으면 option에 따라 Memory Cache에 저장 후 이미지 반환
            if let cachedImage = self.diskCache.loadImage(url: url) {
                let timeTaken = CFAbsoluteTimeGetCurrent() - diskStartTime
                print("Time taken from Disk Cache: \(String(format: "%.7f", timeTaken)) seconds")
                self.memoryCache.saveImage(image: cachedImage,
                                           url: url,
                                           option: saveOption)
                completion(cachedImage)
                return
            }
            
            let serverStartTime = CFAbsoluteTimeGetCurrent()
            
            // Disk Cache에도 없으면
            // 서버로부터 데이터를 가져오고
            // option에 따라 Memory Cache, Disk Cache에 저장
            if let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData) {
                let timeTaken = CFAbsoluteTimeGetCurrent() - serverStartTime
                print("Time taken from Server: \(String(format: "%.7f", timeTaken)) seconds")
                self.memoryCache.saveImage(image: image,
                                           url: url,
                                           option: saveOption)
                self.diskCache.saveImage(image: image,
                                         url: url,
                                         option: saveOption)
                completion(image)
            } else {
                print("서버로부터 Image를 가져오는 데에 실패했습니다.")
                completion(nil)
            }
        }
    }
    
}
