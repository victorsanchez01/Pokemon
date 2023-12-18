//
//  Pokemon.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import Foundation
import SwiftData

@Model
class Pokemon: Identifiable, Equatable, Sequence, IteratorProtocol {
    let id: Int
    let name: String
    let types: [PokemonType]
    let abilities: [String]
    let moves: [String]
    let image: String
    let color: String
    
    init(id: Int, name: String, types: [PokemonType], abilities: [String], moves: [String], image: String, color: String) {
        self.id = id
        self.name = name
        self.types = types
        self.abilities = abilities
        self.moves = moves
        self.image = image
        self.color = color
    }
    
    private var currentIndex = 0
    
    func makeIterator() -> Pokemon {
        currentIndex = 0
        return self
    }
    
    func next() -> Pokemon? {
        guard currentIndex < 1 else {
            return nil
        }
        currentIndex += 1
        return self
    }
}
