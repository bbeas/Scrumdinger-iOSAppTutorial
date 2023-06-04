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
    @State private var scrums = DailyScrum.sampleData
    // a scene can transition between three phases
    // active, inactive, background
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
