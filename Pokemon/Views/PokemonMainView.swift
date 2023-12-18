//
//  PokemonMainView.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import SwiftUI

struct PokemonMainView: View {
    @StateObject var viewModel: PokemonViewModel
    @State private var isFilterSelectionPresented: Bool = false
    
    private let pokemonColumns: [GridItem] = {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return Array(repeating: GridItem(.flexible()), count: 4)
        } else {
            return Array(repeating: GridItem(.flexible()), count: 2)
        }
    }()
    
    var body: some View {
        NavigationView {
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
                    LazyVGrid(columns: pokemonColumns, spacing: 24) {
                        ForEach(viewModel.filteredPokemons) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonCellView(pokemon: pokemon)
                            }
                        }
                    }
                    .animation(.easeIn(duration: 0.2), value: viewModel.filteredPokemons.count)
                    .padding(.bottom, 16)
                    
                    // This section behaves according to viewModel uiState
                    bottomSection()
                    
                }
            }
            .padding()
            .sheet(isPresented: $isFilterSelectionPresented) {
                FilterSelectionView(selectedTypes: $viewModel.selectedTypes, viewModel: viewModel)
            }
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
}

#Preview {
    PokemonMainView(viewModel: PokemonViewModel(useCase: PokemonUseCase()))
}

struct FilterSelectionView: View {
    @Binding var selectedTypes: [PokemonType]
    var viewModel: PokemonViewModel
    let allPokemonTypes: [PokemonType] = [
        .bug, .dark, .dragon, .electric, .fairy, .fighting, .fire, .flying,
        .ghost, .grass, .ground, .ice, .normal, .poison, .psychic, .rock, .steel, .water
    ]
    
    var body: some View {
        Text("Select filter options")
            .padding()
        
        List(allPokemonTypes, id: \.self) { type in
            HStack {
                Text(type.rawValue.capitalized)
                Spacer()
                Button(action: {
                    viewModel.toggleTypeSelection(type)
                }) {
                    Image(systemName: selectedTypes.contains(type) ? "checkmark.square.fill" : "square")
                }
            }
        }
        .padding()
    }
}
