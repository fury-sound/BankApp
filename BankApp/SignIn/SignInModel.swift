//
//  SignInModel.swift
//  BankApp
//
//  Created by Valery Zvonarev on 28.04.2026.
//

import Foundation

struct UserModel: Codable {
    let login: String
    let password: String
//    let userName: String?
//    let email: String?
//    let phone: String?
}

struct UserData: Codable {
    let login: String
    let password: String
    let passwordConfirm: String
}
