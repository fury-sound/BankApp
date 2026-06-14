//
//  NewsCellViewModel.swift
//  BankApp
//
//  Created by Valery Zvonarev on 19.05.2026.
//

import Foundation

final class NewsCellViewModel {

    func dateFormatted(with dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
            //        formatter.locale = Locale(identifier: "ru_RU")
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = inputFormatter.date(from: dateString) else {
            return dateString
        }
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .long
            //        outputFormatter.locale = Locale.current
        outputFormatter.locale = Locale(identifier: "ru_RU")
            //        outputFormatter.timeStyle = .none
        return outputFormatter.string(from: date)
    }
}
