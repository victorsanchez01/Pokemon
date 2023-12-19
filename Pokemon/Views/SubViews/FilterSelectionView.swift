//
//  FilterSelectionView.swift
//  Pokemon
//
//  Created by Victor Sanchez on 19/12/23.
//

import SwiftUI

struct FilterSelectionView: View {
    @Binding var selectedTypes: [PokemonType]
    @Binding var isFilterSelectionPresented: Bool
    var viewModel: PokemonViewModel
    
    var body: some View {
        HStack {
            Button {
                isFilterSelectionPresented.toggle()
            } label: {
                Text("X")
                    .bold()
            }
            Spacer()
        }
        .padding(.leading)
        .padding(.top)
        Text("Select filters")
            .padding(.bottom)
        List(PokemonType.allCases, id: \.self) { type in
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
        .padding(.horizontal)
    }
}

#Preview {
    FilterSelectionView(selectedTypes: .constant([]), isFilterSelectionPresented: .constant(false), viewModel: PokemonViewModel(useCase: PokemonUseCase()))
}
