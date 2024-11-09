//
//  Group.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 27/09/23.
//

import Foundation
import SwiftData

@Model
final class Group {
    var id: UUID = UUID()
    var name: String
    @Relationship(deleteRule: .nullify, inverse: \Card.groups)
    var cards: [Card] = []
    
    init(name: String) {
        self.name = name
    }
}
