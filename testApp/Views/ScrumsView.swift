//
//  ScrumsView.swift
//  testApp
//
//  Created by Shen Beibei on 03/06/2023.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]

    // observe this value and save user data when it becomes inactive
    @Environment(\.scenePhase) private var scenePhase

    @State private var isPresentingNewScrumView = false

    let saveAction: () -> Void

    var body: some View {
        NavigationStack {
            // list needs a way to identify individual items in the collection, it will use id by default
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        // use onChange to trigger actions when a specified value changes
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                saveAction()
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        // use a constant to create a binding to an immutable value (for preview only)
        ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
    }
}
