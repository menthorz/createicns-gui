//
//  main.swift
//  createicns-gui
//

import SwiftUI

struct CreateICNSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}

// Entry point
CreateICNSApp.main()
