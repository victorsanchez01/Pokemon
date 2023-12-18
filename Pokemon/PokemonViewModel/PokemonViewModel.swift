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
}

