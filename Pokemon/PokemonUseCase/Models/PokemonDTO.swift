//
//  PokemonDTO.swift
//  Pokemon
//
//  Created by Victor Sanchez on 17/12/23.
//

import Foundation

struct PokemonDTO: Decodable {
    let count: Int
    let next: String?
    let results: [PokemonList]
}

struct PokemonList: Decodable {
    let name: String
    let url: String
}
