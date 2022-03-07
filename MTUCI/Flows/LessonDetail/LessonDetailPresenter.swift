// Created by Anatoly Qstove on 06.03.2022.

import Foundation
import UIKit

final class LessonDetailPresenter: LessonDetailPresenterInput {

    weak var view: LessonDetailViewInput?

    func present(_ response: LessonDetailModule.UseCase.Load.Response) {
        view?.viewModel.title = response.lesson.timeStart + " — " + response.lesson.timeEnd
        view?.viewModel.lesson = response.lesson
        view?.viewModel.cellTypes = getCellTypes(response)
    }

    private func getCellTypes(_ response: LessonDetailModule.UseCase.Load.Response) -> [LessonDetailModule.CellTypes] {
        return [
            .disciplineCell(disciplineName: response.lesson.discipline),
            .infoCell(
                title: response.role == .teacher ? "Группа:" : "Преподаватель: ",
                subtitle: response.role == .teacher ? response.lesson.group : response.lesson.teacher),
            .infoCell(title: "Начало:", subtitle: response.lesson.timeStart),
            .infoCell(title: "Окончание:", subtitle: response.lesson.timeEnd),
            .infoCell(title: "Аудитория:", subtitle: response.lesson.auditory),
            .urlCell(title: "Ссылка для удаленного доступа", placeholder: "Не указано", urlString: response.lesson.linkForRemote),
            .commentFieldCell(title: "Комментарий", text: response.lesson.comments, commentsIsEditable: response.role == .teacher),
            response.role == .teacher ? .buttonCell(title: "Сохранить комментарий") : nil
        ].compactMap { $0 }
    }
}
