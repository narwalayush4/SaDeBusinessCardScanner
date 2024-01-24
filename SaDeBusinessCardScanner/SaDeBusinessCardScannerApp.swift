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
    @Environment(\.scenePhase) var scenePhase
    
    // for debugging purposes
    @State private var startTime: Date = Date()
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    debugPrint("view appeared at: \(Date())")
                }
                .onChange(of: scenePhase) {
                    let endTime = Date()
                    let elapsedTime = endTime.timeIntervalSince(startTime)
//                    debugPrint(startTime)
//                    debugPrint(endTime)
//                    debugPrint("Time from app launch to main view appearance: \(elapsedTime) seconds")
                }
        }
        .onChange(of: scenePhase) {
            persistenceController.save()
        }
    }
}
