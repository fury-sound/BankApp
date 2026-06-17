//
//   TabViewScreen.swift
//  BankApp
//
//  Created by Valery Zvonarev on 30.04.2026.
//

import UIKit

final class TabViewScreen: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarAppearance()
//        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTabs() {
        let mainVC = MainPageViewController()
        mainVC.title = "Новости банка"
        mainVC.tabBarItem.tag = 0
        mainVC.tabBarItem = UITabBarItem(
            title: "Новости",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        let mainNav = UINavigationController(rootViewController: mainVC)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 28, weight: .bold)
        ]
        mainNav.navigationBar.standardAppearance = appearance
        mainNav.navigationBar.scrollEdgeAppearance = appearance

//        mainNav.navigationBar.prefersLargeTitles = true

        let rateVC = SiteRateViewController()
        rateVC.tabBarItem = UITabBarItem(
            title: "Курсы обмена",
//            image: UIImage(systemName:  "gear"),
            image: UIImage(systemName: "banknote") ,
            selectedImage: UIImage(systemName: "banknote.fill")
        )
        rateVC.title = "Курсы обмена"
//        settingsVC.navigationItem.largeTitleDisplayMode = .always
        rateVC.tabBarItem.tag = 1
        let rateNav = UINavigationController(rootViewController: rateVC)
        rateNav.navigationBar.standardAppearance = appearance
        rateNav.navigationBar.scrollEdgeAppearance = appearance

        let settingsVC = SettingsPageViewController()
        settingsVC.tabBarItem = UITabBarItem(
            title: "Настройки",
            image: UIImage(systemName: "gear"),
            selectedImage: UIImage(systemName: "gear.fill")
        )
        settingsVC.title = "Настройки"
//        settingsVC.navigationItem.largeTitleDisplayMode = .always
        settingsVC.tabBarItem.tag = 2
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        settingsNav.navigationBar.standardAppearance = appearance
        settingsNav.navigationBar.scrollEdgeAppearance = appearance

        viewControllers = [
            mainNav,
            rateNav,
            settingsNav
        ]
    }

//    private func setupTabs() {
//        let mainVC = MainPageViewController()
//        mainVC.tabBarItem = UITabBarItem(
//            title: "Главная",
//            image: UIImage(systemName: "house"),
//            selectedImage: UIImage(systemName: "house.fill")
//        )
//        mainVC.tabBarItem.tag = 0
//        mainVC.navigationItem.largeTitleDisplayMode = .always
//        mainVC.title = "Главная"
//
//        let settingsVC = SettingsPageViewController()
//        settingsVC.tabBarItem = UITabBarItem(
//            title: "Настройки",
//            image: UIImage(systemName: "gear"),
//            selectedImage: UIImage(systemName: "gear.fill")
//        )
//        settingsVC.title = "Настройки"
//        settingsVC.navigationItem.largeTitleDisplayMode = .always
//        settingsVC.tabBarItem.tag = 1
//
//        viewControllers = [
//            UINavigationController(rootViewController: mainVC),
//            UINavigationController(rootViewController: settingsVC),
//        ]
//    }

    private func setupTabBarAppearance() {}

}

#Preview {
    TabViewScreen()
}
