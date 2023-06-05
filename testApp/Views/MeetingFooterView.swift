//
//  MeetingFooterView.swift
//  testApp
//
//  Created by Shen Beibei on 04/06/2023.
//

import SwiftUI
struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    // closure property
    var skipAction: () -> Void

    private var speakerNumber: Int? {
        // the first speaker not marked as completed becomes the active speaker
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }

    // is true if the isCompleted property of each speaker except the final speaker is true
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }

    private var speakerText: String {
        guard let speakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }

    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
