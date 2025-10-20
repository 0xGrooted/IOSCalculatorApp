//
//  CalculatorGameApp.swift
//  MyFirstIiOSApp
//
//  Created by Mark Moore on 20/10/2025.
//


//
//  CalculatorGameApp.swift
//  CalculatorGame
//
//  Created by Mark Moore on 20/10/2025.
//

import SwiftUI
import SwiftData

@main
struct CalculatorGameApp: App {
    // This sets up the database for our app.
    // Notice we've changed the Schema to save 'CalculationItem' objects now.
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CalculationItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            // This is the first screen the user sees.
            ContentView()
        }
        // This makes the database available to all our views.
        .modelContainer(sharedModelContainer)
    }
}
