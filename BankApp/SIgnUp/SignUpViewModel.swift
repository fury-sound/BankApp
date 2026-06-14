    //
    //  SignUpViewModel.swift
    //  BankApp
    //
    //  Created by Valery Zvonarev on 10.04.2026.
    //

import Foundation
import Security

final class SignUpViewModel {
//    var userName = "admin"
//    var password = "123"
    private let keychainService = "com.bank.app"
    private let userLoggedFlag: String = "isUserLogged"
    var errorText: String?

    func userIsLoggedIn() {
        UserDefaults.standard.set(true, forKey: userLoggedFlag)
        print("User logged status:", UserDefaults.standard.bool(forKey: userLoggedFlag))
    }

    func checkCredentials(name: String, password: String) -> Bool {
        guard !name.isEmpty else {
            print("⚠️ Введите имя пользователя")
            errorText = " ⚠️ Введите имя пользователя"
            return false
        }
        guard !password.isEmpty else {
            print("⚠️ Введите пароль")
            errorText = " ⚠️ Введите пароль"
            return false
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: name,
            kSecReturnData as String: true,
            //            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let checkStatus = SecItemCopyMatching(query as CFDictionary, &result)
        switch checkStatus {
            case errSecSuccess:
                if let data = result as? Data, let storedPassword = String(data: data, encoding: .utf8) {
                    if password == storedPassword {
                        print("👤 Вы вошли в систему")
                        print("Имя пользователя-пароль: \(name) - \(password)")
                        return true
                    } else {
                        print("⚠️ Неверное имя пользователя или пароль")
//                        errorText = " ⚠️ Неверное имя пользователя или пароль"
                    }
                }
            case errSecItemNotFound:
                print("⚠️ Неверное имя пользователя или пароль")
            default:
                print("⚠️ Неверное имя пользователя или пароль")
        }
        errorText = " ⚠️ Неверное имя пользователя или пароль"
        return false
    }
}
