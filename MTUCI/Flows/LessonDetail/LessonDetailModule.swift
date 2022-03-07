// Created by Anatoly Qstove on 06.03.2022.

import Combine
import NetworkKit

protocol LessonDetailInteractorInput: AnyObject {
    func load()
}

protocol LessonDetailPresenterInput: AnyObject {
    func present(_ response: LessonDetailModule.UseCase.Load.Response)
}

protocol LessonDetailViewInput: AnyObject {
    var viewModel: LessonDetailModule.ViewModel { get }
}

protocol LessonDetailRouter: AnyObject {
    func route(output: LessonDetailModule.Output)
}

enum LessonDetailModule {

    ///Типы ячеек модуля
    enum CellTypes {
        case disciplineCell(disciplineName: String)
        case infoCell(title: String, subtitle: String)
        case urlCell(title: String, placeholder: String, urlString: String?)
        case commentFieldCell(title: String, text: String?, commentsIsEditable: Bool)
        case buttonCell(title: String)
    }

    enum UseCase {
        enum Load {
            struct Response {
                let lesson: ScheduleResponse.Lesson
                let role: AuthResponse.Role
            }
        }
    }

    final class ViewModel: ObservableObject {
        @Published
        var title: String? = "LessonDetail"
        @Published
        var lesson: ScheduleResponse.Lesson?
        @Published
        var cellTypes = [CellTypes]()
    }

    enum Output {

    }
}
