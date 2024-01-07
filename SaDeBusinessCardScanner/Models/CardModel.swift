//
//  Card.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import Foundation

struct CardModel {
//    var name : String?
//    var company : String?
//    var jobTitle: String?
//    var email : String?
//    var phone : String?
//    var address : String? // long strings address how?
//    var imageName : String? // stores the name of the image stored, to be fetched later
//    var group: Group?
//    var website: String?
//    var text: [String]?
    
    var name_: String = ""
    var jobTitle_: String = ""
    var company_: String = ""
    var phone_: String = ""
    var address1_: String = ""
    var address2_: String = ""
    var address3_: String = ""
    var email_: String = ""
    var website_: String = ""
//    var filePath_: String = ""
    var timeStamp_: Date = Date()
    var options: [String] = ["text 1", "text 2", "text 3",]

}
