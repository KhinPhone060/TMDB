//
//  TMDBApp.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import SwiftUI

@main
struct TMDBApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}