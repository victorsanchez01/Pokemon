//
//  APIError.swift
//  Pokemon
//
//  Created by Victor Sanchez on 17/12/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}
