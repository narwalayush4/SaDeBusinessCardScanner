//
//  Card.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 02/11/24.
//

import Foundation
import SwiftData

@Model
final class Card {
    var id: UUID = UUID()
    var fullAddress: String {
        return [address1, address2, address3].filter { !$0.isEmpty }.joined(separator: "; ")
    }
    var address1: String
    var address2: String
    var address3: String
    var company: String
    var email: String
    var filePath: String
    var jobTitle: String
    var name: String
    var phone: String
    var timeStamp: Date
    var website: String
    var options: [String] = []
    var groups: Group? = nil
    
    init(
        address1: String = "",
        address2: String = "",
        address3: String = "",
        company: String = "",
        email: String = "",
        filePath: String = "",
        jobTitle: String = "",
        name: String = "",
        phone: String = "",
        timeStamp: Date = Date(),
        website: String = ""
    ) {
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
        self.company = company
        self.email = email
        self.filePath = filePath
        self.jobTitle = jobTitle
        self.name = name
        self.phone = phone
        self.timeStamp = timeStamp
        self.website = website
    }
    
    static var shared: Card {
        let card = Card()
        card.name = "John Doe"
        card.company = "Example Company"
        card.jobTitle = "Software Engineer"
        card.email = "john.doe@example.com"
        card.phone = "1234567890"
        card.website = "www.example.com"
        card.address1 = "123 Main Street"
        card.timeStamp = Date(timeIntervalSince1970: 60000)
        return card
    }
}
