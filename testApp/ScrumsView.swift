//
//  ScrumsView.swift
//  testApp
//
//  Created by Shen Beibei on 03/06/2023.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
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
                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        // use a constant to create a binding to an immutable value (for preview only)
        ScrumsView(scrums: .constant(DailyScrum.sampleData))
    }
}
