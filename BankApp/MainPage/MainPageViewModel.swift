//
//  MainPageViewModel.swift
//  BankApp
//
//  Created by Valery Zvonarev on 11.05.2026.
//

import UIKit

enum NewsViewState {
    case idle
    case loading
    case loaded([NewsCellModel])
    case error(String)
}

final class MainPageViewModel {
//    var bankNews: [NewsCellModel] = []
    private let networkService = NetworkService.shared
    private let notificationService = NotificationService.shared
//    private let center = UNUserNotificationCenter.current()

    private(set) var state: NewsViewState = .idle {
        didSet {
            stateDidChange?(state)
        }
    }

    var stateDidChange: ((NewsViewState) -> Void)?

    //    var textBody: String = ""
    //    var newsArrays: [NewsCellModel] = []

    //    init() {
    ////        createArray()
    //    }

    func fetchNews() {
        print("in", #function)
        state = .loading
        //        print(#function)
        //        bankNews = []
        //        networkService.fetch(endpoint: .news) { [weak self] result in
        networkService.fetch { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let news):
                    self.state = .loaded(news)
                    Task {
                        await self.notificationService.resetBadgeCount()
                    }
                    self.reScheduledNotifications(for: news)
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
            }
            //                switch result {
            //                    case .success(let news):
            //                        self?.bankNews = news
            //
            //                        self?.newsTableView.reloadData()
            //                    case .failure(let error):
            //                        print(error.localizedDescription)
            //                        self?.showConnectionErrorView()
            //                }
            //                self?.activityIndicator.stopAnimating()
        }
    }

    // MARK: Private methods

    private func reScheduledNotifications(for news: [NewsCellModel]) {
        print("in", #function)
//        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
//        guard !hasLaunchedBefore else { return }

        notificationService.requestPermission { [weak self] granted in
            guard granted, let self else { return }
//            print("granted, self == nil", granted, self == nil)
            self.notificationService.scheduleNotification(from: news)
//            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        }
    }
}

//    func createArray() {
//        textBody = "Описание 1 Описание 1 Описание 1 Описание 1 Описание 1 Описание 1 Описание 1 Описание 1 Описание 1 Описание 1 "
//        newsArrays = [
//            NewsCellModel(title: "Заголовок 1", mainText: textBody, date: "12.05.2026", imageName: "https://i.pinimg.com/originals/0c/0d/0f/0c0d0f30000000000000000000000000.jpg", pageLink: "https://google.com"),
//            NewsCellModel(title: "Заголовок 2", mainText: "Описание 2", date: "11.05.2026", imageName: "https://i.pinimg.com/originals/0c/0d/0f/0c0d0f30000000000000000000000000.jpg", pageLink: "https://google.com"),
//            NewsCellModel(title: "Заголовок 3", mainText: "Описание 3", date: "10.05.2026", imageName: "https://i.pinimg.com/originals/0c/0d/0f/0c0d0f30000000000000000000000000.jpg", pageLink: "https://google.com"),
//            NewsCellModel(title: "Заголовок 4", mainText: "Описание 4", date: "09.05.2026", imageName: "https://i.pinimg.com/originals/0c/0d/0f/0c0d0f30000000000000000000000000.jpg", pageLink: "https://google.com"),
//            NewsCellModel(title: "Заголовок 1", mainText: "Описание 1", date: "12.05.2026", imageName: "https://i.pinimg.com/originals/0c/0d/0f/0c0d0f30000000000000000000000000.jpg", pageLink: "https://google.com"),
//            NewsCellModel(title: "Заголовок 2", mainText: "Описание 2", date: "11.05.2026", imageName: "https://i.pinimg.com/originals/0c/0d/0f/0c0d0f30000000000000000000000000.jpg", pageLink: "https://google.com"),
//            NewsCellModel(title: "Заголовок 3", mainText: "Описание 3", date: "10.05.2026", imageName: "https://i.pinimg.com/originals/0c/0d/0f/0c0d0f30000000000000000000000000.jpg", pageLink: "https://google.com"),
//            NewsCellModel(title: "Заголовок 4", mainText: "Описание 4", date: "09.05.2026", imageName: "https://i.pinimg.com/originals/0c/0d/0f/0c0d0f30000000000000000000000000.jpg", pageLink: "https://google.com"),
//        ]
//    }

//}
