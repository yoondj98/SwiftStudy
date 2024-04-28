//
//  SceneDelegate.swift
//  UIKitImageCachingStudy
//
//  Created by 윤동주 on 4/27/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }

}

