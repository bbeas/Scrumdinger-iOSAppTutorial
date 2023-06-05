//
//  testAppApp.swift
//  testApp
//
//  Created by Shen Beibei on 02/06/2023.
//

import SwiftUI

// the @main attribute inform the system this is the only entry point to my app
@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    // a scene can transition between three phases
    // active, inactive, background
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {
                // Task allows you to async execute a code block
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
