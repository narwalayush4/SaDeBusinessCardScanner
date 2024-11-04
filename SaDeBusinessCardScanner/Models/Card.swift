//
//  Card.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 02/11/24.
//

import Foundation
import SwiftData

@Model final class Card {
    var address: String
    var company: String
    var email: String
    var filePath: String
    var jobTitle: String
    var name: String
    var phone: String
    var timeStamp: Date
    var website: String
    var options: [String] = []
    
    init(
        address: String = "",
        company: String = "",
        email: String = "",
        filePath: String = "",
        jobTitle: String = "",
        name: String = "",
        phone: String = "",
        timeStamp: Date = Date(),
        website: String = ""
    ) {
        self.address = address
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
        card.address = "123 Main Street"
        card.timeStamp = Date(timeIntervalSince1970: 60000)
        return card
    }
}
