//
//  Card+CoreDataClass.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 10/11/23.
//
//

import Foundation
import CoreData

@objc(Card)
public class Card: NSManagedObject {

    static var shared:Card {
        let previewContext = PersistenceController.preview.container.viewContext
        let card = Card(context: previewContext)
        card.name_ = "John Doe"
        card.company_ = "Example Company"
        card.jobTitle_ = "Software Engineer"
        card.email_ = "john.doe@example.com"
        card.phone_ = "1234567890"
        card.website_ = "www.example.com"
        card.address_ = "123 Main Street"
        card.timeStamp_ = Date(timeIntervalSince1970: 60000)
        return card
    }
}
