// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import UIKit
import NavigationKit
import NetworkKit

final class MainCoordinator {
    private let navigationController: UINavigationController
    private let isStubbed: Bool
    private let services: ApplicationServices
    private let person: AuthResponse.Person

    private var sheduleCoordinator: SheduleCoordinator?
    private var newsCoordinator: NewsCoordinator?
    private var profileCoordinator: ProfileCoordinator?

    init(services: ApplicationServices, navigationController: UINavigationController, person: AuthResponse.Person, isStubbed: Bool) {
        self.services = services
        self.navigationController = navigationController
        self.person = person
        self.isStubbed = isStubbed
    }

    func start() {
        let tabVC: UITabBarController = UITabBarController()

        let scheduleNavigation = UINavigationController()
        sheduleCoordinator = SheduleCoordinator(
            rootViewController: scheduleNavigation,
            services: services,
            isStubbed: true
        )
        sheduleCoordinator?.start()
        scheduleNavigation.tabBarItem = UITabBarItem(title: "Расписание ", image: UIImage(named: "bookmark"), selectedImage: nil)

        let newsNavigation = UINavigationController()
        newsCoordinator = NewsCoordinator(
            rootViewController: newsNavigation,
            services: services,
            isStubbed: true
        )
        newsCoordinator?.start()
        newsNavigation.tabBarItem = UITabBarItem(title: "Новости", image: UIImage(named: "list"), selectedImage: nil)

        let profileNavigation = UINavigationController()
        profileCoordinator = ProfileCoordinator(
            rootViewController: profileNavigation,
            services: services,
            isStubbed: true
        )
        profileCoordinator?.start()
        profileNavigation.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "graduation_cap"), selectedImage: nil)

        tabVC.viewControllers = [scheduleNavigation, newsNavigation, profileNavigation]
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([tabVC], animated: false)
    }
}
