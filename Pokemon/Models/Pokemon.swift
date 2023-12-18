//
//  Pokemon.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import Foundation

struct Pokemon: Identifiable, Equatable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let abilities: [String]
    let moves: [String]
    let image: String
}
