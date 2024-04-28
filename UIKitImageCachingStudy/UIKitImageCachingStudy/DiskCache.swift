//
//  DiskCache.swift
//  UIKitImageCachingStudy
//
//  Created by 윤동주 on 4/28/24.
//

import UIKit

class DisckCache: Cacheable {
    static var shared = DisckCache()
    private var fileManager = FileManager.default
    
    func loadImage(url: URL) -> UIImage? {
        if let filePath = checkPath(url),
           fileManager.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)
        }
        return nil
    }
    
    func saveImage(image: UIImage,
                   url: URL,
                   option: SaveOption) {
        // Memory에만 저장하거나 저장을 안하는 경우 return
        if option == .onlyMemory || option == .none {
            return
        }
        
        if let filePath = checkPath(url),
           !(fileManager.fileExists(atPath: filePath)) {
            if fileManager.createFile(atPath: filePath,
                                      contents: image.jpegData(compressionQuality: 1.0),
                                      attributes: nil) {
                print("Disk에 저장했습니다.")
            } else {
                print("Disk 공간이 부족합니다.")
            }
            
        }
    }
    
    // URL로 fileManager 내에서 데이터를 찾을 fileURL 생성
    private func checkPath(_ url: URL) -> String? {
        let key = createKey(from: url)
        
        /// Home 디렉토리에 있는 Cache 디렉토리 경로
        let documentsURL = try? fileManager.url(
            for: .cachesDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)
        let fileURL = documentsURL?.appendingPathComponent(key)
        
        return fileURL?.path
    }
}

