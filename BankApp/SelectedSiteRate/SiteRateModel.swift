//
//  SiteRateModel.swift
//  BankApp
//
//  Created by Valery Zvonarev on 19.05.2026.
//

import Foundation

struct BranchViewModel {
    let rates: [RateRowModel]
    let workHours: String
    let branchNumber: String
    let address: String
}

struct RateViewModel: Codable {
    let usdIn: String
    let usdOut: String
    let eurIn: String
    let eurOut: String
    let rubIn: String
    let rubOut: String
//    let rateUSD: RateRowModel
//    let rateEUR: RateRowModel
//    let rateRUB: RateRowModel
//    let inUSDEur: String
//    let outUSDEur: String
//    let inUSDRub: String
//    let outUSDRub: String
//    let inRubEur: String
//    let outRubEur: String
//    let rates: [RateRowModel]
    let workHours: String
    let branchNumber: String
    let streetType: String
    let street: String
    let building: String
    let location: String
    let locationType: String

    enum CodingKeys: String, CodingKey {
        case usdIn = "USD_in"
        case usdOut = "USD_out"
        case eurIn = "EUR_in"
        case eurOut = "EUR_out"
        case rubIn = "RUB_in"
        case rubOut = "RUB_out"
        case workHours = "info_worktime"
        case branchNumber = "filials_text"
        case streetType = "street_type"
        case street = "street"
        case building = "home_number"
        case location = "name"
        case locationType = "name_type"
    }
}

extension RateViewModel {
    func toViewModel() -> BranchViewModel {
        let rates: [RateRowModel] = [
            RateRowModel(currency: "🇺🇸 USD - 🇧🇾 BelRub", buyRate: usdIn, sellRate: usdOut),
            RateRowModel(currency: "🇪🇺 EUR - 🇧🇾 BelRub", buyRate: eurIn, sellRate: eurOut),
            RateRowModel(currency: "🇷🇺 RUB - 🇧🇾 BelRub", buyRate: rubIn, sellRate: rubOut)
        ]

        let address = "\(streetType) \(street) \(building), \(location)"

        return BranchViewModel(rates: rates, workHours: workHours, branchNumber: branchNumber, address: address)
    }

}

