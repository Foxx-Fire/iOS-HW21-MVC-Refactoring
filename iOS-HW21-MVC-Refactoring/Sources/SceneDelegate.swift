//
//  SceneDelegate.swift
//  iOS-HW21-MVC-Refactoring
//
//  Created by FoxxFire on 12.09.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let navigationManager = NavigationAppearanceManager()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        navigationManager.setupGlobalAppearance()
        
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
    }
}
