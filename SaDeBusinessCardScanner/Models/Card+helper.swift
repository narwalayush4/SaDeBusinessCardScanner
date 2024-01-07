////
////  Card+Helper.swift
////  SaDeBusinessCardScanner
////
////  Created by Ayush Narwal on 05/11/23.
////
//
//import Foundation
//import CoreData
//
//extension Card {
//    
//    var email: String {
//        get { email_ ?? ""  }
//        set { email_ = newValue }
//    }
//    var website: String {
//        get { website_ ?? ""  }
//        set { website_ = newValue }
//    }
//    var phone: String {
//        get { phone_ ?? ""  }
//        set { phone_ = newValue }
//    }
//    var company: String {
//        get { company_ ?? ""  }
//        set { company_ = newValue }
//    }
//    var name: String {
//        get { name_ ?? ""  }
//        set { name_ = newValue }
//    }
//    var jobTitle: String {
//        get { jobTitle_ ?? ""  }
//        set { jobTitle_ = newValue }
//    }
//    var address1: String {
//        get { address1_ ?? ""  }
//        set { address1_ = newValue }
//    }
//    var address2: String {
//        get { address2_ ?? ""  }
//        set { address2_ = newValue }
//    }
//    var address3: String {
//        get { address3_ ?? ""  }
//        set { address3_ = newValue }
//    }
//    var timeStamp: Date {
//        get { timeStamp_ ?? Date()}
//        set { timeStamp_ = newValue }
//    }
//    var filePath: String {
//        get { filePath_ ?? ""}
//        set { filePath_ = newValue}
//    }
//    convenience init(context: NSManagedObjectContext,
//                     email: String,
//                     website: String,
//                     phone: String,
//                     company: String,
//                     name: String,
//                     jobTitle: String,
//                     address1: String,
//                     address2: String,
//                     address3: String,
//                     timeStamp: Date,
//                     filePath: String
//    ) {
//        self.init(context: context)
//        self.email = email
//        self.website = website
//        self.phone = phone
//        self.company = company
//        self.jobTitle = jobTitle
//        self.address1 = address1
//        self.address2 = address2
//        self.address3 = address3
//        self.timeStamp = timeStamp
//        self.filePath = filePath
//        
//    }
//    
//}
