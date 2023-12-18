//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Victor Sanchez on 18/12/23.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    
    let pokemon: Pokemon
    private let columns: [GridItem] = {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return Array(repeating: GridItem(.flexible()), count: 8)
            
        } else {
            return Array(repeating: GridItem(.flexible()), count: 3)
        }
    }()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 16) {
                Text(pokemon.name)
                    .font(.largeTitle)
                
                ZStack {
                    KFImage(URL(string: pokemon.image))
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 16)
                        .padding(.trailing, 16)
                        .frame(width: 220, height: 220)
                }
                .frame(width: 250, height: 250)
                .background(Color(pokemon.color))
                .overlay(Color.black.opacity(0.02))
                .clipShape(Circle())
                .shadow(radius: 4)
                
                HStack(alignment: .bottom) {
                    ForEach(pokemon.types) { type in
                        HStack(spacing: 8) {
                            Image(type.rawValue)
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text(type.rawValue.capitalized)
                                .font(.subheadline)
                                .foregroundStyle(Color.white)
                                .bold()
                        }
                        .padding(6)
                        .padding(.trailing, 8)
                        .background(Color(type.rawValue))
                        .overlay(Color.black.opacity(0.05))
                        .clipShape(Capsule())
                    }
                }
                .padding(.bottom, 16)
                
                Text("Abilities:")
                    .font(.subheadline)
                    .bold()
                abilities(from: pokemon.abilities)
                
                Text("Moves:")
                    .font(.subheadline)
                    .bold()
                moves(from: pokemon.moves)
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func abilities(from values: [String]) -> some View {
        HStack(spacing: 8) {
            ForEach(values, id: \.self) { value in
                Text(value)
                    .font(.subheadline)
                    .bold()
            }
            .padding(6)
            .background(Color(.systemGray6))
            .overlay(Color.black.opacity(0.05))
            .clipShape(Capsule())
        }
        .padding(.bottom, 16)
    }
    
    @ViewBuilder
    private func moves(from values: [String]) -> some View {
        LazyVGrid(columns: columns, alignment: .center) {
            ForEach(values, id: \.self) { value in
                Text(value)
                    .font(.caption)
                    .bold()
            }
            .padding(6)
            .background(Color(.systemGray6))
            .overlay(Color.black.opacity(0.05))
            .clipShape(Capsule())
        }
        .padding(.bottom, 16)
        .padding(.horizontal, 16)
    }
}

#Preview {
    PokemonDetailView(pokemon: .init(
        id: 1,
        name: "Bulbasaur",
        types: [.electric, .flying],
        abilities: ["Sturdy", "Volt Absorb"],
        moves: ["Razor Wind", "Swords Dance", "Cut"],
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png",
        color: "electric")
    )
    .padding()
}
