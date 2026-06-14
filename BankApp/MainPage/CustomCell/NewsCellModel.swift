//
//  NewsCellModel.swift
//  BankApp
//
//  Created by Valery Zvonarev on 11.05.2026.
//

import Foundation

struct NewsCellModel: Codable {
    let title: String
    let mainText: String
    let date: String
    let imageName: String
    let pageLink: String

    enum CodingKeys: String, CodingKey {
        case title = "name_ru"
        case mainText = "html_ru"
        case date = "start_date"
        case imageName = "img"
        case pageLink = "link"
    }
}
