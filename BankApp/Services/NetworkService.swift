//
//  NetworkService.swift
//  BankApp
//
//  Created by Valery Zvonarev on 14.05.2026.
//

import Foundation

struct News: Codable {
    let news: [NewsCellModel]
}

struct RateView: Codable {
    let rateView: [RateViewModel]
}

enum NetworkServiceError: Error {
    case invalidURL                 // некорректный URL
    case invalidResponse            // пустой/некорректный ответ
    case httpError(statusCode: Int) // ошибка HTTP
    case decodingError(Error)       // ошибка парсинга JSON
    case networkError(Error)        // проблема сетевого соединения

    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "Invalid URL"
            case .invalidResponse:
                return "No data in response"
            case .httpError(statusCode: let code):
                return "HTTP error: \(code)"
            case .decodingError(let error):
                return "Decoding error: \(error.localizedDescription)"
            case .networkError(let error):
                return "Network error: \(error.localizedDescription)"
        }
    }
}

final class NetworkService {
    static let shared = NetworkService()
//    private let baseURL = "https://api.ratesapi.io/api/latest"
    private let baseURL = "https://belarusbank.by/api"
    private let session: URLSession
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        session = URLSession(configuration: configuration)
    }
    
    func fetchRate(completion: @escaping (Result<[RateViewModel], Error>) -> Void) {
//    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
//        URLSession.shared.dataTask(with: url) { [self] data, response, error in
//        URLSession.shared.dataTask(with: url) { data, _, _ in
        print("in", #function )
//            guard let url = URL(string: "\(baseURL)/kursExchange?city=Минск") else {
            guard let url = URL(string: "\(baseURL)/kursExchange") else {
                completion(.failure(NetworkServiceError.invalidURL))
                return
            }
        print("url", url)
            let task = session.dataTask(with: url) { data, response, error in
                if let error {
                    completion(.failure(NetworkServiceError.networkError(error)))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkServiceError.invalidResponse))
                    return
                }

                guard (200..<300).contains(httpResponse.statusCode) else {
                    completion(.failure(NetworkServiceError.httpError(statusCode: httpResponse.statusCode)))
                    return
                }

                guard let data else {
                    completion(.failure(NetworkServiceError.invalidResponse))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let allRates = try decoder.decode([RateViewModel].self, from: data)
                    completion(.success(allRates))
                } catch {
                    completion(.failure(NetworkServiceError.decodingError(error)))
                }
            }
        task.resume()
    }

    func fetch(completion: @escaping (Result<[NewsCellModel], Error>) -> Void) {
//    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
//        URLSession.shared.dataTask(with: url) { [self] data, response, error in
//        URLSession.shared.dataTask(with: url) { data, _, _ in
        print("in", #function )
            guard let url = URL(string: "\(baseURL)/news_info?lang=ru") else {
                completion(.failure(NetworkServiceError.invalidURL))
                return
            }
        print("url", url)
            let task = session.dataTask(with: url) { data, response, error in
                if let error {
                    completion(.failure(NetworkServiceError.networkError(error)))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkServiceError.invalidResponse))
                    return
                }

                guard (200..<300).contains(httpResponse.statusCode) else {
                    completion(.failure(NetworkServiceError.httpError(statusCode: httpResponse.statusCode)))
                    return
                }

                guard let data else {
                    completion(.failure(NetworkServiceError.invalidResponse))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let allNews = try decoder.decode([NewsCellModel].self, from: data)
                    completion(.success(allNews))
                } catch {
                    completion(.failure(NetworkServiceError.decodingError(error)))
                }
            }
        task.resume()
    }
}
