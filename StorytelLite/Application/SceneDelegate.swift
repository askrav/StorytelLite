//
//  SceneDelegate.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import UIKit
import SnapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = BookListBuilder(resolver: AppContainer.current).build()
        window?.makeKeyAndVisible()
    }
}
