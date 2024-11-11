//
//  SaDeBusinessCardScannerApp.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import SwiftUI
import SwiftData

@main
struct SaDeBusinessCardScannerApp: App {
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Group.self, Card.self)
            let descriptor = FetchDescriptor<Group>()
            let groups = try container.mainContext.fetch(descriptor)
            if groups.isEmpty {
                DefaultGroupsManager.setupDefaultGroups(modelContext: container.mainContext)
            }
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(container)
    }
}
