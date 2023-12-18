//
//  PokemonDataDTO.swift
//  Pokemon
//
//  Created by Victor Sanchez on 17/12/23.
//

import Foundation

struct PokemonDataDTO: Decodable {
    let id: Int
    let name: String
    let types: [PokemonTypeDTO]
    let abilities: [PokemonAbilitiesDTO]
    let moves: [PokemonMovesDTO]
    let image: Other
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case types
        case abilities
        case moves
        case image = "sprites"
    }
}

struct PokemonTypeDTO: Decodable, PokemonStats {
    let type: StatName
}

struct PokemonAbilitiesDTO: Decodable, PokemonStats {
    let ability: StatName
}

struct PokemonMovesDTO: Decodable, PokemonStats {
    let move: StatName
}

struct StatName: Decodable {
    let name: String
}

struct Other: Decodable {
    let other: OfficialArtwork
}

struct OfficialArtwork: Decodable {
    let officialArtwork: FrontDefault
    
    private enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct FrontDefault: Decodable {
    let frontDefault: String
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

protocol PokemonStats {}
