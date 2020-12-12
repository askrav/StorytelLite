//
//  AppDelegate.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private lazy var modules: [AppModule] = [
        CommonModule(container: AppContainer.current)
    ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadModules()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

// MARK: - Modules
private extension AppDelegate {
    func loadModules() {
        for module in modules {
            if module.shouldLoadModule() {
                module.load()
            }
        }
    }
}
