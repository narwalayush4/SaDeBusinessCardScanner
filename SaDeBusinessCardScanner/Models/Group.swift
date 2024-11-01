//
//  Group.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 27/09/23.
//

import Foundation

struct Group: Identifiable {
    var id = UUID()
    var name: String
    var cards: [CardModel] = []
}
