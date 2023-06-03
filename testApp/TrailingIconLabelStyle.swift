//
//  TrailingIconLabelStyle.swift
//  testApp
//  Create a label style to stack the scrum length and clock icon horizontally
//  Reuse the same label style for several views
//
//  Created by Shen Beibei on 03/06/2023.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
