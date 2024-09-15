//
//  InformationFinderApp.swift
//  InformationFinder
//
//  Created by Rhianna McCormack on 17/8/2024.
//

import SwiftUI
import SwiftData

@main
struct InformationFinderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Topic.self) // creates container for persistent data

    }
}
