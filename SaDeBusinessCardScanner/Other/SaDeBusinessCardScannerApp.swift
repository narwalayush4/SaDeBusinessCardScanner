//
//  SaDeBusinessCardScannerApp.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import SwiftUI

@main
struct SaDeBusinessCardScannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
