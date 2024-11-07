//
//  MicroQRApp.swift
//  MicroQR
//
//  Created by Bastiaan Quast on 11/7/24.
//

import SwiftUI

@main
struct MicroQRApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
