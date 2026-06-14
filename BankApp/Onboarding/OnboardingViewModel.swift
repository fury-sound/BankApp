//
//  OnboardingViewModel.swift
//  BankApp
//
//  Created by Valery Zvonarev on 06.05.2026.
//

import UIKit

final class OnboardingViewModel {
    var pages: [OnboardingContentViewController] = []
    weak var delegate: OnboardingPageViewControllerDelegate?

    private let pageData: [PageInfo] = [
        PageInfo(pageTag: 1, mainText: "Лучшее банковское приложение", imageName: "Onboarding1", buttonText: "Продолжить"),
        PageInfo(pageTag: 2, mainText: "Интуитивный интерфейс под разнообразные задачи", imageName: "Onboarding2", buttonText: "Продолжить"),
        PageInfo(pageTag: 3, mainText: "Начните использовать приложение", imageName: "Onboarding3", buttonText: "Перейти в приложение")
    ]

    func setPages() {
        for elem in 0..<pageData.count {
            let contentVC = OnboardingContentViewController()
            contentVC.configure(pageData: pageData[elem], viewModel: self)
            pages.append(contentVC)
        }
    }

    func goToNextPage(currentPage: Int, onboardingVC: UIViewController) {
        self.delegate?.goToNextPage()
    }

    func goToMainWindow(onboardingVC: UIViewController) {
        UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        if let sceneDelegate = onboardingVC.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            let signUpVC = SignUpViewController()
            let navVC = UINavigationController(rootViewController: signUpVC)
            //            guard let window = sceneDelegate.window else { return }
            UIView.transition(with: window, duration: 0.7, options: .transitionFlipFromRight) {
                sceneDelegate.window?.rootViewController = navVC
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
