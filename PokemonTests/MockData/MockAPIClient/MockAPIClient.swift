//
//  MockAPIClient.swift
//  PokemonTests
//
//  Created by Victor Sanchez on 18/12/23.
//

import Foundation
@testable import Pokemon

final class MockAPIClient: APIClientProtocol {
    
    var pokemonDTOResponse: Result<PokemonDTO, APIError>?
    var pokemonDataDTOResponse: Result<PokemonDataDTO, APIError>?
    
    init() { /* Do nothing here*/ }
    
    func fetch<T>(from endpoint: String, responseType: T.Type) async throws -> T where T : Decodable {
        if let pokemonDTOResponse {
            switch pokemonDTOResponse {
                case .success(let T):
                    self.pokemonDTOResponse = nil
                    return T as! T
                case .failure(let error):
                    throw APIError.requestFailed(error)
            }
        } else if let pokemonDataDTOResponse {
            switch pokemonDataDTOResponse {
                case .success(let T):
                    self.pokemonDataDTOResponse = nil
                    return T as! T
                case .failure(let error):
                    throw APIError.requestFailed(error)
            }
        } 
        return responseType as! T
    }
    
}
