//
//  PokemonMainView.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import SwiftUI

struct PokemonMainView: View {
    var pokemons: [Pokemon]?
    @State var search = String()
    
    private let pokemonColumns: [GridItem] = {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        } else {
            return [GridItem(.flexible()), GridItem(.flexible())]
        }
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Pokédex")
                .font(.largeTitle)
            Text("Use the advanced search to find Pokémon by type(s), abilities and moves")
                .font(.subheadline)
            HStack(spacing: 4) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search a pokémon", text: $search)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                }
                .padding(12)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3.decrease")
                        .tint(Color(.darkGray))
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: pokemonColumns, spacing: 24) {
                    ForEach(0..<20) { _ in
                        PokemonCellView(pokemon: .init(
                            id: 1,
                            name: "Bulbasaur",
                            types: [.electric, .flying],
                            abilities: ["Sturdy", "Volt Absorb"],
                            moves: ["Razor Wind", "Swords Dance", "Cut"],
                            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"))
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    PokemonMainView()
}
