// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import NetworkKit

final class ProfileInteractor: ProfileInteractorInput {

    var presenter: ProfilePresenterInput?
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
        let provider = services.api.provider(for: ProfileService.self, stubBehavior: stubBehavior)
        provider.request(.profile(userId: userId, role: role.rawValue.lowercased())) { [weak self] result in
            guard let self = self else { return }
            switch self.role {
            case .teacher:
                let result: Result<ProfileTeacherResponse, Error> = MoyaProcessor.DecodableResultProcessor(result)
                switch result {
                case .success(let response):
                    let response = ProfileModule.UseCase.Load.TeacherResponse(teacherProfile: response)
                    self.presenter?.present(response)
                case .failure:
                    break
                }
            case .student:
                let result: Result<ProfileStudentResponse, Error> = MoyaProcessor.DecodableResultProcessor(result)
                switch result {
                case .success(let response):
                    let response = ProfileModule.UseCase.Load.StudentResponse(studentProfile: response)
                    self.presenter?.present(response)
                case .failure:
                    break
                }
            }
            self.presenter?.presentIsLoading(false)
        }
    }
}
