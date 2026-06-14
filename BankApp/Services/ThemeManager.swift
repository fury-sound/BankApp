//
//  ThemeManager.swift
//  BankApp
//
//  Created by Valery Zvonarev on 11.05.2026.
//

import UIKit

enum Theme: Int {
    case light = 0
    case dark = 1
    case system = 2
}

final class ThemeManager {
    static let shared = ThemeManager()

    var currentTheme = Theme.system {
        didSet {
            applyTheme()
            saveThemeToUserDefaults()
        }
    }

    private init() {
        loadThemeFromUserDefaults()
        //        if let themeRawValue = UserDefaults.standard.value(forKey: "currentTheme") as? String,
        //           let theme = Theme(rawValue: themeRawValue) {
        //            currentTheme = theme
        //        }
    }

    private func applyTheme() {
        let currentUIStyle: UIUserInterfaceStyle
        switch currentTheme {
            case .light:
                currentUIStyle = .light
            case .dark:
                currentUIStyle = .dark
            case .system:
                currentUIStyle = .unspecified
        }

        UIApplication.shared.connectedScenes.forEach { scene in
            if let windowScene = scene as? UIWindowScene {
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = currentUIStyle
                }
            }
        }

//        let windows = UIApplication.shared.windows
//        switch currentTheme {
//            case .light:
//                windows.forEach { $0.overrideUserInterfaceStyle = .light }
//            case .dark:
//                windows.forEach { $0.overrideUserInterfaceStyle = .dark }
//            case .system:
//                windows.forEach { $0.overrideUserInterfaceStyle = .unspecified }
//        }
    }

    private func saveThemeToUserDefaults() {
//        print("in", #function)
        let themeValue: String
        switch currentTheme {
            case .light:
                themeValue = "light"
            case .dark:
                themeValue = "dark"
            case .system:
                themeValue = "system"
        }
        UserDefaults.standard.set(themeValue, forKey: "selectedTheme")
    }

    private func loadThemeFromUserDefaults() {
//        print("in", #function)
        let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme") ?? "system"
        switch savedTheme {
            case "light":
                currentTheme = .light
            case "dark":
                currentTheme = .dark
            default:
                currentTheme = .system
        }
//        if let themeRawValue = UserDefaults.standard.value(forKey: "selectedTheme") as? String,
//           let theme = Theme(rawValue: themeRawValue) {
//            currentTheme = theme
//        }
    }
}
