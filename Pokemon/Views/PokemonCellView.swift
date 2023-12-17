//
//  PokemonCellView.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import SwiftUI
import Kingfisher

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
                .padding(.bottom, 16)
                .font(.subheadline)
                .foregroundStyle(Color.white)
                .bold()
                
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        ForEach(pokemon.types) { type in
                            HStack(spacing: 2) {
                                Image(type.rawValue)
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text(type.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(Color.white)
                            }
                            .padding(4)
                            .background(Color.black.opacity(0.12))
                            .clipShape(Capsule())
                        }
                    }
                    Spacer()
                    KFImage(URL(string: pokemon.image))
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 4)
                        .padding(.trailing, 4)
                        .frame(width: 60, height: 60)
                }
            }
            .padding(8)
        }
        .background(.purple)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 4)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PokemonCellView(pokemon: .init(
        id: 1,
        name: "Bulbasaur",
        types: [.electric, .flying],
        abilities: ["Sturdy", "Volt Absorb"],
        moves: ["Razor Wind", "Swords Dance", "Cut"],
        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png")
    )
    .padding()
}
