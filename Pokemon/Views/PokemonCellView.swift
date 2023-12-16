//
//  PokemonCellView.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import SwiftUI

struct PokemonCellView: View {
    let pokemon: Pokemon
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .bottom) {
                    Text(pokemon.name)
                    Spacer()
                    Text("# \(pokemon.id)")
                }
            }
        }
    }
}

#Preview {
    PokemonCellView(pokemon: .init(
        id: 1,
        name: "Bulbasaur",
        types: [.electric, .flying],
        abilities: ["Sturdy", "Volt Absorb"],
        moves: ["Razor Wind", "Swords Dance", "Cut"],
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
    )
    .padding()
}
