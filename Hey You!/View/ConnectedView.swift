//
//  ConnectedView.swift
//  Hey You!
//
//  Created by Brendan on 2021-03-24.
//

import SwiftUI

struct ConnectedView: View {
    @ObservedObject var model: ConnectionModel

    @State private var showSettings = false

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Button(
                    action: {
                        showSettings = true
                    }, label: {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 34, height: 34)
                    }
                )

                Spacer()
            }.padding()

            Spacer()

            HStack {
                Spacer()

                DanceButton(
                    height: 125,
                    danceSubject: model.danceSubject
                )

                Spacer()

                BigButton(
                    color: Color(red: 0, green: 1, blue: 0, opacity: 1),
                    size: .small,
                    text: "I'm Hungry",
                    colorSubject: model.colorSubject
                )

                Spacer()
            }

            BigButton(
                color: Color(red: 1, green: 0, blue: 0, opacity: 1),
                size: .big,
                text: "Hey You!",
                colorSubject: model.colorSubject
            )

            Spacer()
        }.background(model.danceColor)
        .sheet(
            isPresented: $showSettings,
            content: {
                SettingsView(model: model, showSheet: $showSettings)
            }
        )
    }
}
