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

    // an optional state variable
    // the default value of an optional is nil
    @State private var errorWrapper: ErrorWrapper?

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
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
