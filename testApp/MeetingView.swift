//
//  ContentView.swift
//  testApp
//
//  Created by Shen Beibei on 02/06/2023.
//

import AVFoundation
import SwiftUI

// conforms to the View protocol and has a body property
struct MeetingView: View {
    @Binding var scrum: DailyScrum
    // @StateObject means the view owns the source of truth for the obejct
    // It ties the Scrum Timer (ObservableObject) to the MeetingView lifecycle
    // to keep it alive for the lifecycle of the view
    @StateObject var scrumTimer = ScrumTimer()

    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                Circle().strokeBorder(lineWidth: 24)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                // ensure the audio file always plays from the beginning
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// defines a preview for that view to display
struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
