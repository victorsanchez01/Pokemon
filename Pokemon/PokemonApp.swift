//
//  PokemonApp.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import SwiftUI
import SwiftData

@main
struct PokemonApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        let viewModel = PokemonViewModel(useCase: PokemonUseCase())
        WindowGroup {
            PokemonMainView(viewModel: viewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
