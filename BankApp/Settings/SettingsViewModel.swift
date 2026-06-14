    //
    //  SettingsViewModel.swift
    //  BankApp
    //
    //  Created by Valery Zvonarev on 09.05.2026.
    //

import UIKit

final class SettingsViewModel {
    var themeManager = ThemeManager.shared
    private let keychainService = "com.bank.app"
    private let userLoggedFlag: String = "isUserLogged"
        //    var currentTheme = ThemeManager.shared.currentTheme
    private var notificationsStatus: Bool = false

    func changeTheme(_ themeIndex: Int) {
            //        currentTheme.toggle()
            //        UserDefaults.standard.set("dark", forKey: "currentTheme")
        switch themeIndex {
            case 0:
                themeManager.currentTheme = .light
            case 1:
                themeManager.currentTheme = .dark
            default:
                themeManager.currentTheme = .system
        }
            //        print("themeManager.currentTheme", themeManager.currentTheme)
            //        print("in UserDefaults selectedTheme:", UserDefaults.standard.string(forKey: "selectedTheme"))
    }

    func userNotLoggedIn() {
        UserDefaults.standard.set(false, forKey: userLoggedFlag)
        print("User logged status:", UserDefaults.standard.bool(forKey: userLoggedFlag))
    }

    func toggleNotifications() {
        notificationsStatus.toggle()
        print(notificationsStatus)
    }

    func showAllAccountInfo() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecReturnAttributes as String: true,
            kSecMatchLimit as String: kSecMatchLimitAll
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        switch status {
            case errSecSuccess:
                guard let items = result as? [[String: Any]] else { return }
                items.forEach {
                    let accountName = $0[kSecAttrAccount as String] as? String ?? "no name"
                    print("• account: \"\(accountName)\"")
//                    print($0)
                }
            case errSecItemNotFound:
                print("📭 Keychain пуст для сервиса \"\(keychainService)\"")
            default:
                print("❌ loadAllAccounts → OSStatus: \(status)")
        }
    }

    func removeAllAccounts() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService
        ]
        let status = SecItemDelete(query as CFDictionary)
        switch status {
            case errSecSuccess:
                print("🗑️ Keychain успешно очищен для сервиса \"\(keychainService)\". Аккаунты удалены.")
            default:
                print("❌ removeAllAccounts → OSStatus: \(status)")
        }
        showAllAccountInfo()
    }

    func exitProfile(currentView: UIViewController) {
        userNotLoggedIn()
        let vc = SignUpViewController()
        let navVC = UINavigationController(rootViewController: vc)
        if let sceneDelegate = currentView.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            UIView.transition(with: window, duration: 0.7, options: .transitionFlipFromRight) {
                sceneDelegate.window?.rootViewController = navVC
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
