//
//  DetailEditView.swift
//  testApp
//
//  Created by Shen Beibei on 04/06/2023.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    // @State defines the source of truth for value types
    @State private var newAttendeeName = ""
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                // $ syntax creates a binding to scrum.title
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5 ... 30, step: 1) {
                        // Text won't appear onscreen, but VoiceOver uses it to identify the purpose of the slider
                        Text("Length")
                    }
                    .accessibilityLabel("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes").accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        // pass a constant binding to the initializer
        DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
