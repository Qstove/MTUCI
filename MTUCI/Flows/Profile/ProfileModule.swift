// Created by Anatoly Qstove on 02.03.2022.

import Combine
import NetworkKit
import UIKit

protocol ProfileInteractorInput: AnyObject {
    func load()
}

protocol ProfilePresenterInput: AnyObject {
    func present(_ response: ProfileModule.UseCase.Load.TeacherResponse)
    func present(_ response: ProfileModule.UseCase.Load.StudentResponse)
    func presentIsLoading(_ value: Bool)
}

protocol ProfileViewInput: AnyObject {
    var viewModel: ProfileModule.ViewModel { get }
}

protocol ProfileRouter: AnyObject {
    func route(output: ProfileModule.Output)
}

enum ProfileModule {

    ///Типы ячеек модуля
    enum CellTypes {
        /// Фото
        case photoCell(image: UIImage?, placeholder: UIImage)
        /// Ячейка с фио
        case fullNameCell(firstName: String, lastName: String, middleName: String)
        /// Информационная ячейка
        case infoCell(title: String, subtitle: String)
        /// Хедер
        case headerCell(text: String)
    }

    enum UseCase {
        enum Load {
            struct TeacherResponse {
                let teacherProfile: ProfileTeacherResponse
            }
            struct StudentResponse {
                let studentProfile: ProfileStudentResponse
            }
        }
    }

    final class ViewModel: ObservableObject {
        @Published
        var title: String? = "Профиль"
        @Published
        var isLoading: Bool = false
        @Published
        var cellTypes = [CellTypes]()
    }

    enum Output {

    }
}
