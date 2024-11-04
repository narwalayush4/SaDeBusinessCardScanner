//
//  Card.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 02/11/24.
//

import Foundation
import SwiftData

@Model final class Card {
    private(set) var fullAddress: String = ""
    var address1: String { didSet { updateFullAddress() } }
    var address2: String { didSet { updateFullAddress() } }
    var address3: String { didSet { updateFullAddress() } }
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
    
    // Private method to update the full address
    private func updateFullAddress() {
        fullAddress = "\(address1); \(address2); \(address3)"
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
