    //
    //  SignInViewModel.swift
    //  BankApp
    //
    //  Created by Valery Zvonarev on 28.04.2026.
    //

import Foundation

final class SignInViewModel {
    private let keychainService = "com.bank.app"
    var user: UserModel?
    var userData: UserData?
    var errorText: String?
    var signInButtonIsEnabled: Bool = false
    var loginValue: Bool = false {
        didSet {
//            debugPrint("login checked")
            checkUserFields()
        }
    }

    var passwordValue: Bool = false {
        didSet {
//            debugPrint("password checked")
            checkUserFields()
        }
    }

    var passwordConfirmValue: Bool = false {
        didSet {
//            debugPrint("password confirm checked")
            checkUserFields()
        }
    }

    private func checkUserFields() {
//        print("loginValue && passwordValue && passwordConfirmValue", loginValue, passwordValue, passwordConfirmValue)
//        print("loginValue && passwordValue && passwordConfirmValue", loginValue && passwordValue && passwordConfirmValue)
        if (loginValue && passwordValue && passwordConfirmValue) {
//            debugPrint("OK")
            signInButtonIsEnabled = true
        } else {
//            debugPrint("Not OK")
            signInButtonIsEnabled = false
        }
    }

    func signIn(user: UserData) {
        saveCredentials(name: user.login, password: user.password)
//        self.userData = user
//        let user = UserModel(login: user.login, password: user.password)
//        saveUserData(user)
//        if let userData = loadUserData(for: user) {
//            print("userData", userData)
//        }
            //        if user.login == "admin" && user.password == "123456" {
            //            user.login = "admin"
            //        }
    }

//    private func saveUserData(_ user: UserModel) {
//        do {
//            let encoder = JSONEncoder()
//            if let encodedData = try? encoder.encode(user) {
//                UserDefaults.standard.set(encodedData, forKey: user.login)
//            }
//        }
//    }
//
//    private func loadUserData(for user: UserModel) -> UserModel? {
//        guard let userData = UserDefaults.standard.data(forKey: user.login) else { return nil }
//        let decoder = JSONDecoder()
//        return try? decoder.decode(UserModel.self, from: userData)
//    }

    func saveCredentials(name: String, password: String) -> Bool {
        guard let data = password.data(using: .utf8) else {
            debugPrint("Can't read password data")
            return false
        }
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: name
        ]
        SecItemDelete(deleteQuery as CFDictionary)
//        let clearStatus = SecItemDelete(deleteQuery as CFDictionary)
//        print("clearStatus", clearStatus)
//        guard clearStatus == errSecSuccess else {
//            debugPrint("Password data not removed before saving")
//            return false
//        }

        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: name,
            kSecValueData as String: data
        ]

        let saveStatus = SecItemAdd(addQuery as CFDictionary, nil)
        print("saveStatus", saveStatus)
        guard saveStatus == errSecSuccess else {
            debugPrint("Password not saved")
            return false
        }
        return true
    }

    func isUserExist(enteredName: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: enteredName,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
//        print("result", result, "result type", type(of: result))
//        print("status", result[0])
//        print("status", status)

        switch status {
            case errSecSuccess:
                debugPrint("📭 Имя пользователя \"\(enteredName)\" уже есть в Keychain для сервиса \"\(keychainService)\"")
                return true
//                guard let item = result as? [String: Any] else { return }
//                let storedAccount = item[kSecAttrAccount as String] as? String ?? "no name"
//                print("• account: \"\(accountName)\"")
//                print("enteredName, accountName", enteredName, storedAccount)
//                items.forEach {
//                }
            case errSecItemNotFound:
                debugPrint("📭 Имя пользователя \"\(enteredName)\" не занято в Keychain для сервиса \"\(keychainService)\"")
                return false
            default:
                debugPrint("❌ Ошибка! OSStatus: \(status)")
                return false
        }
    }


    func checkNewUserData(userData: UserData) -> Bool {
        if userData.login.isEmpty || userData.password.isEmpty || userData.passwordConfirm.isEmpty {
            debugPrint("Ошибка. Введены не все данные")
            switch true {
                case userData.login.isEmpty:
                    errorText = "Введите логин"
                case userData.password.isEmpty:
                    errorText = "Введите пароль"
                case userData.passwordConfirm.isEmpty:
                    errorText = "Введите подтверждение пароля"
                default:
                    errorText = "Введены не все данные"
            }
            return false
        } else {
            return true
        }
    }

    func loginValidation(login: String) -> String? {
//        isUserExist(enteredName: login)
        if login.isEmpty {
            loginValue = false
            return "Не может быть пустым"
        }
        if isUserExist(enteredName: login) {
            loginValue = false
            return "Имя пользователя \"\(login)\" занято"
        }
        if login.count < 3 {
            loginValue = false
            return "Не менее 3 символов"
        }
        loginValue = true
        return nil
    }

    func passwordValidation(password: String) -> String? {
        if password.count < 6 {
            passwordValue = false
            return "Не менее 6 символов"
        }
        // любые заглавные буквы всех алфавитов
        if password.range(of: "[\\p{Lu}]", options: .regularExpression) == nil {
            passwordValue = false
            return "Не менее 1 заглавной буквы"
        }
        // любые строчные буквы всех алфавитов
        if password.range(of: "[\\p{Ll}]", options: .regularExpression) == nil {
            passwordValue = false
            return "Не менее 1 строчной буквы"
        }
        if password.range(of: "\\d", options: .regularExpression) == nil {
            passwordValue = false
            return "Не менее 1 цифры"
        }
        if password.range(of: "[[:punct:]]", options: .regularExpression) == nil {
            passwordValue = false
            return "Не менее 1 спецсимвола"
        }
        passwordValue = true
        return nil
    }

    func passwordConfirmValidation(password: String, passwordConfirm: String) -> String? {
        if passwordConfirm.isEmpty {
            passwordConfirmValue = false
            return "Не может быть пустым"
        }
        if password != passwordConfirm {
            passwordConfirmValue = false
            return "Пароли не совпадают"
        }
        passwordConfirmValue = true
        return nil
    }


}
