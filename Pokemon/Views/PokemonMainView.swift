//
//  PokemonMainView.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import SwiftUI
import SwiftData

struct PokemonMainView: View {
    // Swift Data
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Pokemon.id) private var storedPokemons: [Pokemon]
    
    @StateObject var viewModel: PokemonViewModel
    @State private var isFilterSelectionPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Pokédex")
                    .font(.largeTitle)
                Text("Use the advanced search to find Pokémon by type(s), abilities and moves")
                    .font(.subheadline)
                HStack(spacing: 4) {
                    
                    // Search section
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
                    
                    // Filter section
                    Button {
                        isFilterSelectionPresented.toggle()
                        viewModel.searchText = ""
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease")
                            .tint(Color(.darkGray))
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    // Pokemon list
                    pokemonsList()
                    
                    // This section behaves according to viewModel uiState
                    bottomSection()
                    
                }
            }
            .padding()
            .sheet(isPresented: $isFilterSelectionPresented) {
                FilterSelectionView(
                    selectedTypes: $viewModel.selectedTypes,
                    isFilterSelectionPresented: $isFilterSelectionPresented,
                    viewModel: viewModel)
            }
            .onChange(of: viewModel.pokemons) {
                storeData(with: viewModel.pokemons)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.reload()
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                    
                }
            }
        }
    }
    
    @ViewBuilder
    private func pokemonsList() -> some View {
        if viewModel.uiState == .error {
            Text("Offline content\nPlease connect to internet and try again")
                .multilineTextAlignment(.center)
                .font(.caption2)
                .foregroundStyle(Color.gray)
                .padding()
            PokemonsGridView(pokemons: storedPokemons, filteredPokemons: viewModel.filteredPokemons)
        } else {
            let pokemons = viewModel.filteredPokemons
            PokemonsGridView(pokemons: pokemons, filteredPokemons: pokemons)
        }
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
    
    private func storeData(with pokemons: [Pokemon]) {
        if storedPokemons.isEmpty {
            for pokemon in pokemons {
                modelContext.insert(pokemon)
            }
            try? modelContext.save()
        }
    }
}

#Preview {
    PokemonMainView(viewModel: PokemonViewModel(useCase: PokemonUseCase()))
}
