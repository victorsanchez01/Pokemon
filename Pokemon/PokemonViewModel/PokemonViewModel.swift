//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Victor Sanchez on 17/12/23.
//

import Foundation

class PokemonViewModel: ObservableObject {
    
    private let useCase: PokemonUseCaseProtocol
    @Published var pokemons: [Pokemon] = []
    @Published var uiState: UIState = .idle
    @Published var searchText = String()
    @Published var selectedTypes: [PokemonType] = []
    
    var filteredPokemons: [Pokemon] {
        if !searchText.isEmpty {
            DispatchQueue.main.async { [weak self] in
                self?.selectedTypes.removeAll()
            }
            return pokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        } else if !selectedTypes.isEmpty {
            return pokemons.filter { selectedTypes.contains($0.types[0]) }
        } else {
            return pokemons
        }
    }
    
    init(useCase: PokemonUseCaseProtocol) {
        self.useCase = useCase
        loadData()
    }
    
    private func loadData() {
        uiState = .loading
        Task { @MainActor in
            let result = try await useCase.loadPokemons()
            switch result {
                case .success(let pokemons):
                    self.pokemons = pokemons
                    uiState = .idle
                case .failure(let error):
                   handleError(error)
            }
        }
    }
    
    func loadMore() {
        uiState = .loading
        Task { @MainActor in
            let result = try await useCase.loadMorePokemons()
            switch result {
                case .success(let pokemons):
                    self.pokemons.append(contentsOf: pokemons)
                    uiState = .idle
                case .failure(let error):
                    handleError(error)
            }
        }
    }
    
    private func handleError(_ error: PokemonUseCaseError) {
        switch error {
            case .generalError:
                uiState = .error
            case .noMorePokemons:
                uiState = .noMore
        }
    }
    
    func toggleTypeSelection(_ type: PokemonType) {
        if selectedTypes.contains(type) {
            selectedTypes.removeAll { $0 == type }
        } else {
            selectedTypes.append(type)
        }
    }
}

