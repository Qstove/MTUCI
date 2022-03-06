// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import UIKit
import NetworkKit
import NavigationKit

protocol SheduleCoordinatorOutput: AnyObject {
    func sheduleCoordinatorDidFinish(_ coordinator: SheduleCoordinator)
}

final class SheduleCoordinator: NavigationCoordinator<SheduleCoordinator.Route> {
    enum Route {
        case shedule
        case lessonDetail(model: ScheduleResponse.Lesson)
//        case flowPlaceholder
    }
    weak var output: SheduleCoordinatorOutput?

    private let services: ApplicationServices
    private let isStubbed: Bool
    private let userId: String
    private let role: AuthResponse.Role

    init(
        rootViewController: UINavigationController,
        services: ApplicationServices,
        isStubbed: Bool,
        userId: String,
        role: AuthResponse.Role
    ) {
        self.services = services
        self.isStubbed = isStubbed
        self.userId = userId
        self.role = role
        super.init(rootViewController: rootViewController)
    }
    
    override func prepareTransition(for route: Route) -> NavigationTransition {
        switch route {
        case .shedule:
            let module = ScheduleConfigurator(isStubbed: isStubbed, services: services).create(router: self, userId: userId, role: role)
            return .push(module)
        case .lessonDetail(let lessonModel):
            let module = LessonDetailConfigurator(isStubbed: isStubbed, services: services)
                .create(
                    router: self,
                    userId: userId,
                    role: role,
                    lessonModel: lessonModel
                )
            return .push(module)
//        case .flowPlaceholder:
//            break
        }
    }

    override func start() {
        trigger(route: .shedule)
    }
    
}

extension SheduleCoordinator: ScheduleRouter {
    func route(output: ScheduleModule.Output) {
        switch output {
        case .lessonDetail(let lessonModel):
            trigger(route: .lessonDetail(model: lessonModel))
        }
    }
}

extension SheduleCoordinator: LessonDetailRouter {
    func route(output: LessonDetailModule.Output) {

    }
}
