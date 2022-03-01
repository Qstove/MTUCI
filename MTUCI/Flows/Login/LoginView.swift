// Created by Anatoly Qstove on 01.03.2022.

import UIKit
import SnapKit
import Foundation
import Combine
import CoreKit

final class LoginView: UIViewController, LoginViewInput {

    let viewModel = LoginModule.ViewModel()
    var interactor: LoginInteractorInput?
    weak var router: LoginRouter?
    private var cancellables: Set<AnyCancellable> = []

    private let mainLabel = UILabel()
    private let loginTextField = UITextFieldWithInset()
    private let passwordField = UITextFieldWithInset()
    private let loginButton = ActionButton(style: .indigo)
    private var loadingVC: LoadingViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor?.load()
    }

    private func setup() {
        setupSubviews()
        setupLayout()
        bind()
    }

    private func setupSubviews() {
        view.backgroundColor = .white

        mainLabel.font = TextStyle.h1.font
        mainLabel.textColor = .indigo
        mainLabel.textAlignment = .center
        view.addSubview(mainLabel)

        loginTextField.placeholder = "Логин"
        loginTextField.layer.borderColor = UIColor.indigo.cgColor
        loginTextField.layer.borderWidth = 1.0
        loginTextField.layer.cornerRadius = 28
        view.addSubview(loginTextField)

        passwordField.placeholder = "Пароль"
        passwordField.layer.borderColor = UIColor.indigo.cgColor
        passwordField.layer.borderWidth = 1.0
        passwordField.layer.cornerRadius = 28
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)

        loginButton.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        view.addSubview(loginButton)
    }

    private func setupLayout() {
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.trailing.leading.equalToSuperview()
        }
        loginTextField.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        passwordField.snp.makeConstraints {
            $0.top.equalTo(loginTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(56)
        }
        loginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }

    private func bind() {
        viewModel.$title
            .weakAssign(to: \.title, on: self)
            .store(in: &cancellables)
        viewModel.$labelText
            .weakAssign(to: \.text, on: mainLabel)
            .store(in: &cancellables)
        viewModel.$isLoading
            .sink(receiveValue: { [weak self] in self?.displayIsLoading($0) })
            .store(in: &cancellables)
        viewModel.$loginButton
            .sink(receiveValue: { [weak self] in self?.displayButton($0) })
            .store(in: &cancellables)
    }

    private func displayButton(_ value: LoginModule.ViewModel.ActionButton?) {
        guard let value = value else { return }
        loginButton.setTitle(value.title, for: .normal)
        loginButton.isEnabled = value.isEnabled
    }

    private func displayIsLoading(_ isLoading: Bool) {
        if isLoading {
            let lvc = LoadingViewController()
            lvc.modalPresentationStyle = .overCurrentContext
            lvc.modalTransitionStyle = .crossDissolve
            present(lvc, animated: true, completion: nil)
            loadingVC = lvc
        } else {
            loadingVC?.dismiss(animated: true, completion: { self.loadingVC = nil  })
        }
    }

    @objc private func loginButtonDidTapped() {
        guard
            let username = loginTextField.text,
            let password = passwordField.text,
            !username.isEmpty && !password.isEmpty else {
                let alertVC = UIAlertController(title: "Введите логин и пароль!", message: "И попробуйте войти вновь!", preferredStyle: .alert)
                alertVC.addAction(.init(title: "Хорошо", style: .cancel))
                present(alertVC, animated: true)
                return
            }
        let request = LoginModule.UseCase.Login.Request(username: username, password: password)
        interactor?.login(request)
    }
}
