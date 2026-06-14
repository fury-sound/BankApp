//
//  RateRowViewModel.swift
//  BankApp
//
//  Created by Valery Zvonarev on 28.05.2026.
//

import Foundation

final class RateRowViewModel {
//    private let rowUSD: RateRowModel = RateRowModel(currency: "🇺🇸 USD - 🇧🇾 BelRub", buyRate: "2.8300", sellRate: "2.9300")
//    private let rowEUR: RateRowModel = RateRowModel(currency: "🇪🇺 EUR - 🇧🇾 BelRub", buyRate: "3.2900", sellRate: "3.4000")
//    private let rowRUB: RateRowModel = RateRowModel(currency: "🇷🇺 RUB - 🇧🇾 BelRub", buyRate: "3.2900", sellRate: "3.8450")

//    var rateArray: [RateRowModel] = []

    var currency = "🇺🇸 USD - 🇧🇾 BelRub!"
    var buyRate = "2.8300"
    var sellRate = "2.9300"

//    init(currency: String = "🇺🇸 USD - 🇧🇾 BelRub", buyRate: String = "2.8300", sellRate: String = "2.9300") {
//    init(currency: String, buyRate: String, sellRate: String) {
//    init(model: RateRowModel) {
    init() {
//        self.currency = currency
//        self.buyRate = buyRate
//        self.sellRate = sellRate
//        self.rateArray = [rowUSD, rowEUR, rowRUB]
    }

//    func configure(with model: RateRowModel) {
    func configure(currency: String, buyRate: String, sellRate: String) {
        self.currency = currency
        self.buyRate = buyRate
        self.sellRate = sellRate
    }
}
