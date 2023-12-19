//
//  PokemonsGridView.swift
//  Pokemon
//
//  Created by Victor Sanchez on 19/12/23.
//

import SwiftUI

struct PokemonsGridView: View {
    
    private let pokemonColumns: [GridItem] = {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return Array(repeating: GridItem(.flexible()), count: 4)
        } else {
            return Array(repeating: GridItem(.flexible()), count: 2)
        }
    }()
    
    let pokemons: [Pokemon]
    let filteredPokemons : [Pokemon]
    
    var body: some View {
        LazyVGrid(columns: pokemonColumns, spacing: 24) {
            ForEach(pokemons) { pokemon in
                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                    PokemonCellView(pokemon: pokemon)
                }
            }
        }
        .animation(.easeIn(duration: 0.2), value: filteredPokemons.count)
        .padding(.bottom, 16)
    }
}

#Preview {
    PokemonsGridView(pokemons: [
        .init(
            id: 1,
            name: "Bulbasaur",
            types: [.electric, .flying],
            abilities: ["Sturdy", "Volt Absorb"],
            moves: ["Razor Wind", "Swords Dance", "Cut"],
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png",
            color: "electric")
    
    ], filteredPokemons: [])
}
