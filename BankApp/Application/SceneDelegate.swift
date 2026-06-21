//
//  SceneDelegate.swift
//  BankApp
//
//  Created by Valery Zvonarev on 10.04.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let userLoggedFlag: String = "isUserLogged"

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let isUserLogged = UserDefaults.standard.bool(forKey: userLoggedFlag)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene

//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = SignUpViewController()
//        self.window = window
//        window.makeKeyAndVisible()

        //        let vc = MainViewController()
//        if UserDefaults.standard.string(forKey: "currentTheme") != nil {
            switch UserDefaults.standard.string(forKey: "selectedTheme") {
                case "dark":
                    windowScene.windows.first?.overrideUserInterfaceStyle = .dark
                case "light":
                    windowScene.windows.first?.overrideUserInterfaceStyle = .light
                default:
                    windowScene.windows.first?.overrideUserInterfaceStyle = .unspecified
            }
//        }
//        windowScene.windows.first?.overrideUserInterfaceStyle = .unspecified

        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            let vc = PageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
            window?.rootViewController = vc
        } else {
//            let vc = SignUpViewController()
//            let navVC = UINavigationController(rootViewController: vc)
//            window?.rootViewController = navVC
            if isUserLogged {
                let vc = TabViewScreen()
//                let navVC = UINavigationController(rootViewController: vc)
                vc.navigationController?.navigationBar.prefersLargeTitles = true
                window?.rootViewController = vc
            } else {
                let vc = SignUpViewController()
                    //            let vc = MainPageViewController()
                    //            let vc = SelectedNewsViewController()
                let navVC = UINavigationController(rootViewController: vc)
                navVC.navigationBar.prefersLargeTitles = true
                window?.rootViewController = navVC
            }
        }
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

