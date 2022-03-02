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
    private var loginCoordinator: LoginCoordinator?
    private var mainCoordinator: MainCoordinator?

    public init(applicationServices: ApplicationServices, window: UIWindow?) {
        self.applicationServices = applicationServices
        self.window = window
    }

    public func start() {
        let navigationController = UINavigationController()
        navigationController.view.backgroundColor = .indigo
        startLoginCoordinator(with: navigationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func startLoginCoordinator(with navigationController: UINavigationController) {
        authenticated = false
        loginCoordinator = LoginCoordinator(rootViewController: navigationController, services: applicationServices, isStubbed: true)
        loginCoordinator?.output = self
        loginCoordinator?.start()
    }

    private func startMainCoordinator(with navigationController: UINavigationController, person: AuthResponse.Person) {
        mainCoordinator = MainCoordinator(services: applicationServices, navigationController: navigationController, person: person, isStubbed: true)
        mainCoordinator?.start()
    }
}

extension RootApplicationCoordinator: LoginCoordinatorOutput {
    func loginCoordinatorDidFinish(person: AuthResponse.Person, _ coordinator: LoginCoordinator) {
        authenticated = true
        loginCoordinator = nil
        guard let nc = window?.rootViewController as? UINavigationController else { return }
        startMainCoordinator(with: nc, person: person)
    }
}
