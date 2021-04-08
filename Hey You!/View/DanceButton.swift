//
//  DanceButton.swift
//  Hey You!
//
//  Created by Brendan on 2021-03-24.
//

import Combine
import SwiftUI

struct DanceButton: View {
    @State private var isSelected: Bool = false

    let height: CGFloat
    let width: CGFloat
    let danceSubject: PassthroughSubject<Void, Never>

    init(height: CGFloat = 250, width: CGFloat? = nil, danceSubject: PassthroughSubject<Void, Never>) {
        self.height = height
        self.width = width ?? height
        self.danceSubject = danceSubject
    }

    var body: some View {
        Button(
            action: {}, label: {
                if isSelected {
                    Image("danceparty_down")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: width, height: height)
                } else {
                    Image("danceparty_up")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: width, height: height)
                }
            }
        ).buttonStyle(PlainButtonStyle())
        .onTouchDownGesture(
            onTap: {
                print("send dance")
                self.danceSubject.send()
                self.isSelected = true
            },
            onEnd: {
                self.isSelected = false
            }
        )
    }
}
