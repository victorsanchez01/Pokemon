//
//  PokemonType.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import Foundation
import SwiftData

enum PokemonType: String, Codable, Equatable, Identifiable {
    case bug = "bug"
    case dark = "dark"
    case dragon = "dragon"
    case electric = "electric"
    case fairy = "fairy"
    case fighting = "fighting"
    case fire = "fire"
    case flying = "flying"
    case ghost = "ghost"
    case grass = "grass"
    case ground = "ground"
    case ice = "ice"
    case normal = "normal"
    case poison = "poison"
    case psychic = "psychic"
    case rock = "rock"
    case steel = "steel"
    case water = "water"
    
    var id: String {
        return rawValue
    }
    
}
