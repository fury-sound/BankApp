//
//  SignInViewController.swift
//  BankApp
//
//  Created by Valery Zvonarev on 28.04.2026.
//

import UIKit

final class SignInViewController: UIViewController {

    // MARK: - Properties

    var viewModel = SignInViewModel()

    private lazy var appLabel: UILabel = {
        let label = UILabel()
        label.text = "РЕГИСТРАЦИЯ"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .label
//        label.backgroundColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Логин"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()

    private lazy var loginError: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemBackground
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()

    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()

    private lazy var passwordError: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemBackground
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()

    private lazy var passwordConfirmLabel: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение пароля"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()

    private lazy var passwordConfirmError: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemBackground
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()
/*
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Полное имя"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .systemBackground
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Электронная почта"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .systemBackground
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Телефон"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .systemBackground
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()
*/
    private lazy var userLogin: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Логин"
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .next
        textField.borderStyle = .none
        textField.layer.cornerRadius = 12
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()

    private lazy var userPassword: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Пароль"
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .next
//        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.layer.cornerRadius = 12
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()

    private lazy var userPasswordConfirm: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Подтверждение пароля"
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .go
//        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.layer.cornerRadius = 12
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
/*
    private lazy var userName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "ФИО"
        textField.font = .systemFont(ofSize: 16)
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
//        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.layer.cornerRadius = 12
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()

    private lazy var userEmail: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Электронная почта"
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .next
//        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.layer.cornerRadius = 12
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()

    private lazy var userPhone: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Телефон"
        textField.font = .systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .go
//        textField.isSecureTextEntry = true
        textField.borderStyle = .none
        textField.layer.cornerRadius = 12
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
*/
    private lazy var signInButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Зарегистрироваться", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .systemGray
////        button.backgroundColor = .systemBlue
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.cornerRadius = 12
        var config = UIButton.Configuration.filled()
        config.title = "Зарегистрироваться"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 16, weight: .semibold)
            return outgoing
        }
        let button = UIButton(configuration: config, primaryAction: nil)
        button.isEnabled = false
        return button
    }()

    // MARK: - Subviews

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }

    // MARK: - Layout
    private func setupViewProperties() {
        userLogin.delegate = self
        userPassword.delegate = self
        userPasswordConfirm.delegate = self
        view.backgroundColor = .systemBackground
    }

    private func setupSubviews() {
        signInButton.addTarget(self, action: #selector(didSignIn), for: .touchUpInside)
        userLogin.addTarget(self, action: #selector(loginChanged), for: .editingChanged)
        userPassword.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        userPasswordConfirm.addTarget(self, action: #selector(passwordConfirmChanged), for: .editingChanged)
//        userName.addTarget(self, action: #selector(enterUserName), for: .editingDidEndOnExit)
//        userPassword.addTarget(self, action: #selector(enterPassword), for: .editingDidEndOnExit)
//        [appLabel, loginLabel, userLogin, passwordLabel, userPassword,  passwordConfirmLabel, userPasswordConfirm, nameLabel, userName, emailLabel, userEmail, phoneLabel, userPhone, singInButton].forEach {
        [appLabel, loginLabel, userLogin, loginError, passwordLabel, userPassword, passwordError, passwordConfirmLabel, userPasswordConfirm, passwordConfirmError, signInButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            appLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            appLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            appLabel.heightAnchor.constraint(equalToConstant: 40),
            loginLabel.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 5),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            loginLabel.heightAnchor.constraint(equalToConstant: 20),
            userLogin.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 5),
            userLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            userLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            userLogin.heightAnchor.constraint(equalToConstant: 40),
            loginError.topAnchor.constraint(equalTo: userLogin.bottomAnchor, constant: 5),
            loginError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            loginError.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            loginError.heightAnchor.constraint(equalToConstant: 15),
            passwordLabel.topAnchor.constraint(equalTo: loginError.bottomAnchor, constant: 5),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            passwordLabel.heightAnchor.constraint(equalToConstant: 20),
            userPassword.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            userPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            userPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            userPassword.heightAnchor.constraint(equalToConstant: 40),
            passwordError.topAnchor.constraint(equalTo: userPassword.bottomAnchor, constant: 5),
            passwordError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            passwordError.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            passwordError.heightAnchor.constraint(equalToConstant: 15),
            passwordConfirmLabel.topAnchor.constraint(equalTo: passwordError.bottomAnchor, constant: 5),
            passwordConfirmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            passwordConfirmLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            passwordConfirmLabel.heightAnchor.constraint(equalToConstant: 20),
            userPasswordConfirm.topAnchor.constraint(equalTo: passwordConfirmLabel.bottomAnchor, constant: 5),
            userPasswordConfirm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            userPasswordConfirm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            userPasswordConfirm.heightAnchor.constraint(equalToConstant: 40),
            passwordConfirmError.topAnchor.constraint(equalTo: userPasswordConfirm.bottomAnchor, constant: 5),
            passwordConfirmError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            passwordConfirmError.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            passwordConfirmError.heightAnchor.constraint(equalToConstant: 15),
//            nameLabel.topAnchor.constraint(equalTo: userPasswordConfirm.bottomAnchor, constant: 10),
//            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//            nameLabel.heightAnchor.constraint(equalToConstant: 20),
//            userName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
//            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//            userName.heightAnchor.constraint(equalToConstant: 50),
//            emailLabel.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10),
//            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//            emailLabel.heightAnchor.constraint(equalToConstant: 20),
//            userEmail.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
//            userEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//            userEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//            userEmail.heightAnchor.constraint(equalToConstant: 50),
//            phoneLabel.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: 10),
//            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//            phoneLabel.heightAnchor.constraint(equalToConstant: 20),
//            userPhone.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5),
//            userPhone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//            userPhone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//            userPhone.heightAnchor.constraint(equalToConstant: 50),
//            singInButton.topAnchor.constraint(equalTo: userPhone.bottomAnchor, constant: 50),
//            signInButton.topAnchor.constraint(equalTo: passwordConfirmError.bottomAnchor, constant: 50),
            signInButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            signInButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }

// MARK: - Actions
    @objc private func loginChanged() {
//        print("in loginChanged, login: \(userLogin.text ?? "none")")
        let login = userLogin.text ?? ""
        if let error = viewModel.loginValidation(login: login) {
            loginError.text = error
            loginError.textColor = .systemRed
        } else {
            loginError.text = "Корректный формат логина"
            loginError.textColor = .systemGreen
        }
        switchSignInButton()
    }

    @objc private func passwordChanged() {
        let password = userPassword.text ?? ""
        if let error = viewModel.passwordValidation(password: password) {
            passwordError.text = error
            passwordError.textColor = .systemRed
        } else {
            passwordError.text = "Корректный формат пароля"
            passwordError.textColor = .systemGreen
        }
        switchSignInButton()
        passwordConfirmChanged()
    }

    @objc private func passwordConfirmChanged() {
        let password = userPassword.text ?? ""
        let passwordConfirm = userPasswordConfirm.text ?? ""
        if let error = viewModel.passwordConfirmValidation(password: password, passwordConfirm: passwordConfirm) {
            passwordConfirmError.text = error
            passwordConfirmError.textColor = .systemRed
        } else {
            passwordConfirmError.text = "Пароль подтвержден"
            passwordConfirmError.textColor = .systemGreen
        }
        switchSignInButton()
    }

    private func switchSignInButton() {
        if viewModel.signInButtonIsEnabled {
            signInButton.backgroundColor = .systemBlue
            signInButton.isEnabled = true
        } else {
            signInButton.backgroundColor = .systemGray
            signInButton.isEnabled = false
        }
    }

    @objc private func didSignIn() {
//        print("sign in user")
        view.endEditing(true)
        let user: UserData = UserData(
            login: userLogin.text ?? "",
            password: userPassword.text ?? "",
            passwordConfirm: userPasswordConfirm.text ?? "")
//        if !viewModel.checkNrData(userData: user) {
//            guard let text = viewModel.errorText else { return }
//            showAlert(title: "⚠️ Ошибка", message: text)
//        } else {
//            viewModel.signIn(user: user)
            if viewModel.saveCredentials(name: user.login, password: user.password) {
                showAlert(title: "👌 Успешно", message: "Данные нового пользователя \"\(user.login)\" сохранены")
            } else {
                showAlert(title: "⚠️ Ошибка", message: "Ошибка сохранения данных")
            }
//        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("in \(#function)")
        switch textField {
            case userLogin:
                loginChanged()
                userPassword.becomeFirstResponder()
            case userPassword:
                passwordChanged()
                userPasswordConfirm.becomeFirstResponder()
            case userPasswordConfirm:
                passwordConfirmChanged()
                if viewModel.signInButtonIsEnabled {
                    didSignIn()
                }
            default:
                textField.resignFirstResponder()
        }
        return true
    }
}

#Preview {
    SignInViewController()
}

