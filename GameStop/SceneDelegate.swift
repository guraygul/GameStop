//
//  SceneDelegate.swift
//  GameStop
//
//  Created by Güray Gül on 18.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene as? UIWindowScene) != nil else { return }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
                let window = UIWindow(windowScene: windowScene)
                self.window = window
                let navigationController = UINavigationController(rootViewController: ViewController())
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
    }
}

