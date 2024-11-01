//
//  Card.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import Foundation

struct CardModel: Identifiable {
    var id = UUID()
    var name_: String = ""
    var jobTitle_: String = ""
    var company_: String = ""
    var phone_: String = ""
    var address1_: String = ""
    var address2_: String = ""
    var address3_: String = ""
    var email_: String = ""
    var website_: String = ""
    var group: Group?
    var timeStamp_: Date = Date()
    var options: [String] = ["text 1", "text 2", "text 3",]
}
