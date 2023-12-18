//
//  PokemonUseCaseTests.swift
//  PokemonTests
//
//  Created by Victor Sanchez on 18/12/23.
//

import Foundation
import XCTest
@testable import Pokemon

final class PokemonUseCaseTests: XCTestCase {
    
    private var mockAPIClient = MockAPIClient()
    private var sut: PokemonUseCase!
    
    override func setUp() {
        self.sut = PokemonUseCase(apiClient: mockAPIClient)
    }
    
    override func tearDown() {
        self.sut = nil
    }
    
    func test_loadPokemonWithSuccessApiResponse() async {
        // given
        mockAPIClient.pokemonDTOResponse = .success(mockPokemonDTO)
        mockAPIClient.pokemonDataDTOResponse = .success(mockPokemonDataDTO)
        
        // when
        let result = await sut.loadPokemons()
        let expectedResult = [mockPokemon]
        
        //then
        switch result {
            case .success(let result):
                XCTAssertEqual(result, expectedResult)
            case .failure(_):
                XCTFail("Expected success")
        }
    }
    
    func test_loadPokemonWithFailedApiResponse() async {
        // given
        mockAPIClient.pokemonDTOResponse = .failure(.invalidResponse)
        
        // when
        let result = await sut.loadPokemons()
        let expectedResult = PokemonUseCaseError.generalError
        
        //then
        switch result {
            case .success(_):
                XCTFail("Expected failure")
            case .failure(let result):
                XCTAssertEqual(result, expectedResult)
        }
    }
    
    func test_loadMorePokemonWithSuccessApiResponseAndNotNilNextURL() async {
        // given
        mockAPIClient.pokemonDTOResponse = .success(mockPokemonDTO)
        mockAPIClient.pokemonDataDTOResponse = .success(mockPokemonDataDTO)
        _ = await sut.loadPokemons()
        mockAPIClient.pokemonDTOResponse = .success(mockPokemonDTO)
        mockAPIClient.pokemonDataDTOResponse = .success(mockPokemonDataDTO)
        
        // when
        let result = await sut.loadMorePokemons()
        let expectedResult = [mockPokemon]
        
        //then
        switch result {
            case .success(let result):
                XCTAssertEqual(result, expectedResult)
            case .failure(_):
                XCTFail("Expected success")
        }
    }
    
    func test_loadMorePokemonWithNilNextURL() async {
        // when
        let result = await sut.loadMorePokemons()
        let expectedResult = PokemonUseCaseError.noMorePokemons
        
        //then
        switch result {
            case .success(_):
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertEqual(error, expectedResult)
        }
    }
}
