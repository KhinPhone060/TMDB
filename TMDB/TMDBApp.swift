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
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        WindowGroup {
            HomeScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    if let directoryLocation = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
                        print("Documents Directory: \(directoryLocation)Application Support")
                    }
                }
        }
    }
}
