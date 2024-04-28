//
//  Model.swift
//  UIKitImageCachingStudy
//
//  Created by 윤동주 on 4/27/24.
//

import Foundation

struct AppInfoResponse: Decodable {
    let resultCount: Int
    let appInfos: [AppInfo]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case appInfos = "results"
    }
}

struct AppInfo: Decodable {
    let title: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case imageUrl = "artworkUrl100"
    }
}
