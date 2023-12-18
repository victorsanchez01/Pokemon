//
//  PokemonAPIClient.swift
//  Pokemon
//
//  Created by Victor Sanchez on 17/12/23.
//

import Foundation

protocol APIClientProtocol {
    func fetch<T: Decodable>(from endpoint: String, responseType: T.Type) async throws -> T
}

class APIClient: APIClientProtocol {
    
    func fetch<T: Decodable>(from endpoint: String, responseType: T.Type) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw APIError.requestFailed(error)
        }
    }
}
