//
//  Group.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 27/09/23.
//

import Foundation
import SwiftData

@Model final class Group {
    var id: UUID = UUID()
    var name: String
    var cards: [Card]
    
    init(name: String, cards: [Card] = []) {
        self.name = name
        self.cards = cards
    }
}
