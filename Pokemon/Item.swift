//
//  Item.swift
//  Pokemon
//
//  Created by Victor Sanchez on 16/12/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
