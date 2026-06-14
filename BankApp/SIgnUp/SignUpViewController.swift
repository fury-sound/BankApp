    //
    //  SignUpViewController.swift
    //  BankApp
    //
    //  Created by Valery Zvonarev on 10.04.2026.
    //

import UIKit

final class SignUpViewController: UIViewController {

        // MARK: - Properties
    private var signUpVM = SignUpViewModel()
//    private var signInButtonBottomConstraint: NSLayoutConstraint?

        // MARK: - Subviews

    private lazy var appLabel: UILabel = {
        let label = UILabel()
        label.text = "Мой банк"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .systemBackground
        label.backgroundColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        label.layer.cornerRadius = 20
        return label
    }()

    lazy var userName: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Имя пользователя"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .next
            //        textField.becomeFirstResponder()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()

    lazy var userPassword: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.placeholder = "Пароль"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .go
            //        textField.becomeFirstResponder()
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()

    private lazy var enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти в приложение", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 12
        return button
    }()

    private lazy var switchSignInView: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
            //        button.backgroundColor = .systemBlue
            //        button.layer.borderWidth = 1
            //        button.layer.borderColor = UIColor.black.cgColor
            //        button.layer.cornerRadius = 12
        return button
    }()

        // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillShow(_:)),
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil
//        )
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillHide(_:)),
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil
//        )
//            //        view.endEditing(true)
//            //        userName.becomeFirstResponder()
//    }

        // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemGray6
    }

    private func setupSubviews() {
        userName.delegate = self
        userPassword.delegate = self
            //        userName.becomeFirstResponder()
            //        userPassword.becomeFirstResponder()
        enterButton.addTarget(self, action: #selector(checkCredentials), for: .touchUpInside)
        switchSignInView.addTarget(self, action: #selector(signInForm), for: .touchUpInside)
            //        userName.addTarget(self, action: #selector(enterUserName), for: .editingDidEndOnExit)
//        userPassword.addTarget(self, action: #selector(enterPassword), for: .editingChanged)
        [userName, userPassword, enterButton, switchSignInView, appLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
//        signInButtonBottomConstraint = signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        NSLayoutConstraint.activate([
            appLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            appLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            appLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            appLabel.heightAnchor.constraint(equalToConstant: 50),
            userName.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 50),
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            userName.heightAnchor.constraint(equalToConstant: 50),
            userPassword.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 30),
            userPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            userPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            userPassword.heightAnchor.constraint(equalToConstant: 50),
            enterButton.topAnchor.constraint(equalTo: userPassword.bottomAnchor, constant: 30),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.widthAnchor.constraint(equalToConstant: 200),
            enterButton.heightAnchor.constraint(equalToConstant: 50),
//                        signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            switchSignInView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20),
            switchSignInView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switchSignInView.widthAnchor.constraint(equalToConstant: 200),
            switchSignInView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

        //    MARK: - Actions
    @objc private func checkCredentials() {
        view.endEditing(true)
        guard let username = userName.text, let password = userPassword.text else { return }
        if signUpVM.checkCredentials(name: username, password: password) {
            print("allowed to enter")
            signUpVM.userIsLoggedIn()
                //            let vc = MainPageViewController()
            let vc = TabViewScreen()
                //            vc.navigationItem.hidesBackButton = true
                //            navigationController?.pushViewController(vc, animated: true)
                //            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                //                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                //                    window.rootViewController = vc
                //                    window.makeKeyAndVisible()
                //                }, completion: nil)
                //            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
                    //                let signUpVC = SignUpViewController()
                    //                let navVC = UINavigationController(rootViewController: signUpVC)
                    //            guard let window = sceneDelegate.window else { return }
                UIView.transition(with: window, duration: 0.7, options: .transitionFlipFromRight) {
                    sceneDelegate.window?.rootViewController = vc
                    sceneDelegate.window?.makeKeyAndVisible()
                }
            }
        } else {
            print("not allowed to enter")
            guard let text = signUpVM.errorText else { return }
            showAlert(title: "Ошибка введенных данных", message: text)
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc private func signInForm() {
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

        //    @objc private func enterUserName() {
        //        print("entered username")
        //    }
//    @objc private func enterPassword() {
//        print("entered password")
//    }

//    @objc private func keyboardWillShow(_ notification: Notification) {
//        guard let userInfo = notification.userInfo,
//              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
//              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
//              let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
//            return
//        }
//        let keyboardHeight = keyboardFrame.height
//        signInButtonBottomConstraint?.constant = -(keyboardHeight + 20)
//        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(rawValue: curveRaw << 16), animations: {
//            self.view.layoutIfNeeded()
//        })
//    }
//
//    @objc private func keyboardWillHide(_ notification: Notification) {
//        guard let userInfo = notification.userInfo,
//              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
//              let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
//            return
//        }
//        signInButtonBottomConstraint?.constant = -30
//        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curveRaw << 16), animations: {
//            self.view.layoutIfNeeded()
//        })
//    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case userName:
                userPassword.becomeFirstResponder()
            case userPassword:
                    //                textField.resignFirstResponder()
                checkCredentials()
            default:
                textField.resignFirstResponder()
        }
        return true
    }
}

#Preview {
    SignUpViewController()
}


