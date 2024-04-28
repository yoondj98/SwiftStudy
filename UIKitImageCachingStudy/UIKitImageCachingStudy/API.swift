//
//  API.swift
//  UIKitImageCachingStudy
//
//  Created by 윤동주 on 4/27/24.
//

import Foundation

class API {
    
    static func searchAppInfo(_ term: String, completion: @escaping ([AppInfo]) -> Void) {
        print(CFAbsoluteTimeGetCurrent(), "검색어로 앱 정보 호출")
        var components = URLComponents(string: "https://itunes.apple.com/search?")!
        
        components.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "country", value: "KR"),
            URLQueryItem(name: "media", value: "software"),
            URLQueryItem(name: "limit", value: "100"),
            URLQueryItem(name: "offset", value: "0"),
        ]
        
        guard let url = components.url else {
            fatalError("URL에 문제가 있습니다.")
        }
        
        URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            let successRange = 200..<300
            
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else {
                completion([])
                return
            }
            
            guard let resultData = data else {
                completion([])
                return
            }
            
            completion(parseAppInfo(resultData))
        }.resume()
    }
    
    static func parseAppInfo(_ data: Data) -> [AppInfo] {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(AppInfoResponse.self, from: data)
            return response.appInfos
        } catch let error {
            print("Parsing 에러 발생: \(error.localizedDescription)")
            return []
        }
    }
    
}

