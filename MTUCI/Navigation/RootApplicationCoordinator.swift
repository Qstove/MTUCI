// Created by Anatoly Qstove on 01.03.2022.

import Foundation
import UIKit
import CoreKit
import NetworkKit
import NavigationKit

public final class RootApplicationCoordinator: NSObject {
    private let window: UIWindow?
    private var applicationServices: ApplicationServices

    @PreferencesStored(key: ApplicationPreferencesKey.authenticated)
    private var authenticated: Bool = false

    public init(applicationServices: ApplicationServices, window: UIWindow?) {
        self.applicationServices = applicationServices
        self.window = window
    }

    public func start() {
        let navigationController = UINavigationController()
        navigationController.view.backgroundColor = .indigo
        startAppropriateCoordinator(with: navigationController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }

    private func startAppropriateCoordinator(with navigationController: UINavigationController) {
        if applicationServices.authService.hasPasscode {
//            startPasscodeCoordinator(with: navigationController)
        } else {
            startLoginCoordinator(with: navigationController)
        }
    }

    private func startLoginCoordinator(with navigationController: UINavigationController) {
        authenticated = false
        let loginCoordinator = LoginCoordinator(rootViewController: navigationController, services: applicationServices, isStubbed: true)
        loginCoordinator.start()
    }

    private func startAuthenticatedCoordinator(with navigationController: UINavigationController) {
        self.authenticated = true

    }
}
