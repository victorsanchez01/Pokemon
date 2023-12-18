//
//  PokemonMainView.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import SwiftUI

struct PokemonMainView: View {
    @StateObject var viewModel: PokemonViewModel
    
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
                    TextField("Search a pokémon", text: $viewModel.searchText)
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
                    ForEach(viewModel.filteredPokemons) { pokemon in
                        PokemonCellView(pokemon: pokemon)
                    }
                }
                .animation(.easeIn(duration: 0.2), value: viewModel.filteredPokemons.count)
                .padding(.bottom, 16)
                
                // This section behaves according to viewModel uiState
                bottomSection()
                
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func bottomSection() -> some View {
        switch viewModel.uiState {
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
            case .idle:
                Button{
                    viewModel.loadMore()
                } label: {
                    Text("Load more")
                        .font(.subheadline)
                        .foregroundStyle(Color.white)
                }
                .padding(EdgeInsets(top: 8, leading: 48, bottom: 8, trailing: 48))
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            case .noMore:
                Text("No more pokemons")
                    .font(.subheadline)
            case .error:
                Text("Error loading data")
                    .font(.subheadline)
                    .foregroundStyle(Color.red)
        }
    }
}

#Preview {
    PokemonMainView(viewModel: PokemonViewModel(useCase: PokemonUseCase()))
}
