//
//  DefaultGroupsManager.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 10/11/24.
//


import SwiftData

class DefaultGroupsManager {
    
    static let defaultGroups = [
        "Family",
        "Business",
        "Customer",
        "Office",
        "Friends",
        "VIP"
    ]
    
    static func setupDefaultGroups(modelContext: ModelContext) {
        for groupName in defaultGroups {
            let group = Group(name: groupName)
            modelContext.insert(group)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving default groups: \(error)")
        }
    }
    
}
