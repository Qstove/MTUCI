// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import NetworkKit

final class ScheduleInteractor: ScheduleInteractorInput {

    var presenter: SchedulePresenterInput?
    private let userId: String
    private let role: AuthResponse.Role
    private let services: ApplicationServices
    private let stubBehavior: NetworkKit.StubBehavior

    init(
        services: ApplicationServices,
        stubBehavior: NetworkKit.StubBehavior,
        userId: String,
        role: AuthResponse.Role
    ) {
        self.services = services
        self.stubBehavior = stubBehavior
        self.userId = userId
        self.role = role
    }

    func load() {

        presenter?.presentIsLoading(true)
        let provider = services.api.provider(for: ScheduleService.self, stubBehavior: stubBehavior)
        provider.request(.schedule(userId: userId, role: role)) { [weak self] result in
            guard let self = self else { return }
            let result: Result<ScheduleResponse, Error> = MoyaProcessor.DecodableResultProcessor(result)
            switch result {
            case .success(let response):
                let response = ScheduleModule.UseCase.Load.Response(schedule: response, role: self.role)
                self.presenter?.present(response)
                break
            case .failure:
                break
            }
            self.presenter?.presentIsLoading(false)
        }
    }
}
