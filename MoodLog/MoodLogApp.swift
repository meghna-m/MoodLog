//
//  MoodLogApp.swift
//  MoodLog
//
//  Created by Meghna . on 22/12/2020.
//

import SwiftUI

@main
struct MoodLogApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
