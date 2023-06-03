//
//  testAppApp.swift
//  testApp
//
//  Created by Shen Beibei on 02/06/2023.
//

import SwiftUI

@main
struct testAppApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
