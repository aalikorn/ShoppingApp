//
//  SceneDelegate.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 10.02.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let searchVC = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let shoppingListVC = ShoppingListViewController()
        let shoppingListNav = UINavigationController(rootViewController: shoppingListVC)
        shoppingListNav.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [searchNav, shoppingListNav]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}

