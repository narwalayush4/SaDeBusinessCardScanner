//
//  DefaultGroupsManager.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 10/11/24.
//


import SwiftData

class DefaultGroupsManager {
    
    static func setupDefaultGroups(modelContext: ModelContext) {
        let defaultGroups = [
            "Family",
            "Business",
            "Customer",
            "Office",
            "Friends",
            "VIP"
        ]
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
