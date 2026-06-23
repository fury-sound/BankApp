//
//  NotificationService.swift
//  BankApp
//
//  Created by Valery Zvonarev on 23.06.2026.
//

import Foundation
import UserNotifications
import UIKit
import OSLog

protocol NotificationServiceProtocol: AnyObject {
    func requestPermission(completion: @escaping (Bool) -> Void)
    func scheduleNotification(from newsArray: [NewsCellModel])
    func resetBadgeCount() async
}

final class NotificationService {
    static let shared = NotificationService()
    private let center = UNUserNotificationCenter.current()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "NotificationService")
    private init() {}

    func requestPermission(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                self.errMessageHandling("Ошибка запроса разрешений: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(granted)
        }
    }

    func scheduleNotification(from newsArray: [NewsCellModel]) {
        //        let firstTenNews = newsArray.flatMap(\.first).prefix(10)
        let firstTenNews = newsArray.prefix(10)
        print("firstTenNews.count", firstTenNews.count)
        center.removeAllPendingNotificationRequests()

//        let currentBadge = UIApplication.shared.applicationIconBadgeNumber // не нужен, так как исходное значение счетчика при загрузке всегда 0

        for (index, news) in firstTenNews.enumerated() {
            let content = UNMutableNotificationContent()
            let newsDate = DateFormatterService.shared.dateFormatted(with: news.date)
            content.title = "Новость Беларусбанка"
            content.subtitle = "Дата: \(newsDate)"
            content.body = "\(index + 1). \(news.title)"
            content.sound = .default
//            content.badge = NSNumber(value: currentBadge + index + 1)
            content.badge = NSNumber(value: index + 1)
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(index + 1) * 300, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(index + 1) * 15, repeats: false)
            let request = UNNotificationRequest(identifier: "bank_news_\(index + 1)", content: content, trigger: trigger)
            center.add(request) { error in
                if let error = error {
                    self.errMessageHandling("Ошибка добавления уведомления: \(error.localizedDescription)")
                }
            }
        }
        Task {
            let pendingRequests = await center.pendingNotificationRequests()
            print("Запланировано: \(pendingRequests.count)")
        }
    }

    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func resetBadgeCount() async { // вместо UIApplication.shared.applicationIconBadgeNumber = 0 (deprecated in 16.0)
        Task {
            do {
                try await center.setBadgeCount(0)
            } catch {
                errMessageHandling("Ошибка сброса числа уведомлений на бедже приложения: \(error.localizedDescription)")
            }
        }
    }

    private func errMessageHandling(_ message: String) {
        debugPrint(message)
        logger.error("\(message)")
    }
}
    //        let content = UNMutableNotificationContent()
    //        content.title = title
    //        content.body = body
    //        content.sound = .default
    //        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)



