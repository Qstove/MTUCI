// Created by Anatoly Qstove on 02.03.2022.

import Foundation
import NetworkKit
import UIKit

final class ProfilePresenter: ProfilePresenterInput {

    weak var view: ProfileViewInput?

    func present(_ response: ProfileModule.UseCase.Load.TeacherResponse) {
        view?.viewModel.title = "Профиль"
        view?.viewModel.cellTypes = getTeacherCellTypes(response)
    }

    func present(_ response: ProfileModule.UseCase.Load.StudentResponse) {
        view?.viewModel.title = "Профиль"
        view?.viewModel.cellTypes = getStudentCellTypes(response)
    }

    func presentIsLoading(_ value: Bool) {
        view?.viewModel.isLoading = value
    }

    private func getTeacherCellTypes(_ response: ProfileModule.UseCase.Load.TeacherResponse) -> [ProfileModule.CellTypes] {
        return [
            .photoCell(image: nil, placeholder: UIImage(named: "photoPlaceholder") ?? UIImage()),
            .fullNameCell(
                firstName: response.teacherProfile.profile.firstName,
                lastName: response.teacherProfile.profile.lastName,
                middleName: response.teacherProfile.profile.middleName
            ),
            .infoCell(title: "Кафедра", subtitle: response.teacherProfile.profile.department),
            .headerCell(text: "Контакты"),
            .infoCell(title: "Почта", subtitle: response.teacherProfile.profile.contacts.email),
            .infoCell(title: "Телефон", subtitle: response.teacherProfile.profile.contacts.phone ?? "Не указан"),
            .infoCell(title: "Telegram", subtitle: response.teacherProfile.profile.contacts.telegram ?? "Не указан"),
        ]
    }

    private func getStudentCellTypes(_ response: ProfileModule.UseCase.Load.StudentResponse) -> [ProfileModule.CellTypes] {
        return [
            .photoCell(image: nil, placeholder: UIImage(named: "photoPlaceholder") ?? UIImage()),
            .fullNameCell(
                firstName: response.studentProfile.profile.firstName,
                lastName: response.studentProfile.profile.lastName,
                middleName: response.studentProfile.profile.middleName
            ),
            .infoCell(title: "Факультет", subtitle: response.studentProfile.profile.faculty),
            .infoCell(title: "Средний балл", subtitle: response.studentProfile.profile.averageMark),
            .headerCell(text: "Контакты"),
            .infoCell(title: "Почта", subtitle: response.studentProfile.profile.contacts.email),
            .infoCell(title: "Телефон", subtitle: response.studentProfile.profile.contacts.phone ?? "Не указан"),
            .infoCell(title: "Telegram", subtitle: response.studentProfile.profile.contacts.telegram ?? "Не указан"),
        ]
    }
}

