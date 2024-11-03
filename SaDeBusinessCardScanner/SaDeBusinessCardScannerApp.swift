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
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Card.self)
    }
}
