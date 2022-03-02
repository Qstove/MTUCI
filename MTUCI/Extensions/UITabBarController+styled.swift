// Created by Anatoly Qstove on 02.03.2022.

import UIKit

extension UITabBarController {
    static var mtuciStyled: UITabBarController {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .rebeccaPurple

        let itemAppearance = tabBarAppearance.stackedLayoutAppearance
        itemAppearance.normal.iconColor = .white
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.cgColor]
        itemAppearance.selected.iconColor = .indigo
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white.cgColor]

        let tabBarController = UITabBarController()
        let tabBar = tabBarController.tabBar
        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }

        return tabBarController
    }
}
