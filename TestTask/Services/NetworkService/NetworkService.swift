//
//  NetworkService.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 19.12.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getData(url: String) async throws  -> Data
}

final class NetworkService: NetworkServiceProtocol {

    func getData(url: String) async throws  -> Data {
        do {
            guard let url = URL(string: url) else { throw Errors.invalidURL}
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }
}


enum Errors: Error {
    case invalidURL
}
