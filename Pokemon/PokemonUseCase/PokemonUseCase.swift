//
//  PokemonUseCase.swift
//  Pokemon
//
//  Created by Victor Sanchez on 17/12/23.
//

import Foundation

protocol PokemonUseCaseProtocol {
    typealias UseCaseResponse = Result<[Pokemon], PokemonUseCaseError>
    func loadPokemons() async throws -> UseCaseResponse
    func loadMorePokemons() async throws -> UseCaseResponse
}

class PokemonUseCase: PokemonUseCaseProtocol {
    private let apiClient: APIClientProtocol
    private var nextURL: String?
    typealias UseCaseResponse = Result<[Pokemon], PokemonUseCaseError>
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func loadPokemons() async -> UseCaseResponse {
        let url: String = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
        do {
            let pokemonResponse = try await apiClient.fetch(from: url, responseType: PokemonDTO.self)
            let pokemons: [Pokemon] = try await fetchPokemonData(pokemonResponse.results)
            nextURL = pokemonResponse.next
            return .success(pokemons)
            
        } catch {
            return .failure(.generalError)
        }
    }
    
    func loadMorePokemons() async -> UseCaseResponse {
        guard let nextURL else { return .failure(.noMorePokemons) }
        do {
            let pokemonResponse = try await apiClient.fetch(from: nextURL, responseType: PokemonDTO.self)
            let pokemons: [Pokemon] = try await fetchPokemonData(pokemonResponse.results)
            self.nextURL = pokemonResponse.next
            return .success(pokemons)
        } catch {
            return .failure(.generalError)
        }
    }
    
    private func fetchPokemonData(_ pokemonResults: [PokemonList]) async throws -> [Pokemon] {
        var pokemons: [Pokemon] = []
        do {
            for pokemon in pokemonResults {
                let pokemonData = try await apiClient.fetch(from: pokemon.url, responseType: PokemonDataDTO.self)
                pokemons.append(map(pokemonData))
            }
            return pokemons
        } catch {
            throw PokemonUseCaseError.generalError
        }
    }
    
    private func map(_ pokemonData: PokemonDataDTO) -> Pokemon {
        return .init(
            id: pokemonData.id,
            name: pokemonData.name.capitalized,
            types: generateTypes(pokemonData.types),
            abilities: generateAbilities(pokemonData.abilities),
            moves: generateMoves(pokemonData.moves),
            image: pokemonData.image.other.officialArtwork.frontDefault)
    }
    
    private func generateTypes(_ types: [PokemonTypeDTO] ) -> [PokemonType] {
        return types.compactMap { type in
            return PokemonType(rawValue: type.type.name)
        }
    }
    
    private func generateAbilities(_ abilities: [PokemonAbilitiesDTO] ) -> [String] {
        return abilities.compactMap { ability in
            return ability.ability.name.replacingOccurrences(of: "-", with: " ").capitalized
        }
    }
    
    private func generateMoves(_ moves: [PokemonMovesDTO] ) -> [String] {
        return moves.compactMap { move in
            return move.move.name.replacingOccurrences(of: "-", with: " ").capitalized
        }
    }
}
