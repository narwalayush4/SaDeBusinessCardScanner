//
//  Card+CoreDataProperties.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 10/11/23.
//
//

import CoreData
import UIKit


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var address_: String
    @NSManaged public var company_: String
    @NSManaged public var email_: String
    @NSManaged public var filePath_: String
    @NSManaged public var jobTitle_: String
    @NSManaged public var name_: String
    @NSManaged public var phone_: String
    @NSManaged public var timeStamp_: Date
    @NSManaged public var website_: String
    
    func fetchImage(fileManager: FileSystem) -> UIImage{
        if let image = fileManager.retrieveImage(from: timeStamp_) {
            return image
        } else {
            return UIImage(named: "logo_512x512")!
        }
    }
}

extension Card : Identifiable {

}
