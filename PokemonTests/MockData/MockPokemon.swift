//
//  MockPokemon.swift
//  PokemonTests
//
//  Created by Victor Sanchez on 18/12/23.
//

import Foundation
@testable import Pokemon

var mockPokemon: Pokemon = .init(
    id: 1,
    name: "Bulbasaur",
    types: [.grass, .poison],
    abilities: ["Sturdy", "Volt Absorb"],
    moves: ["Razor Wind", "Swords Dance", "Cut"],
    image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png",
    color: "grass"
)

var mockPokemonDTO: PokemonDTO = .init(
    count: 1,
    next: "",
    results: [
        PokemonList.init(
            name: "bulbasaur",
            url: "https://pokeapi.co/api/v2/pokemon/1/")
    ]
)

var mockPokemonDataDTO: PokemonDataDTO = .init(
    id: 1,
    name: "bulbasaur",
    types: [
        .init(type: StatName(name: "grass")),
        .init(type: StatName(name: "poison"))
    ],
    abilities: [
        .init(ability: StatName(name: "sturdy")),
        .init(ability: StatName(name: "volt-Absorb"))
    ],
    moves: [
        .init(move: StatName(name: "razor-wind")),
        .init(move: StatName(name: "swords-dance")),
        .init(move: StatName(name: "cut"))
    ],
    image: .init(
        other: OfficialArtwork(
            officialArtwork: FrontDefault(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"
            )
        )
    )
)
