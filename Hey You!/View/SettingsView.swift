//
//  SettingsView.swift
//  Hey You!
//
//  Created by Brendan on 2021-03-25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var model: ConnectionModel

    @Binding private var showSheet: Bool
    @State private var selectedColor = Color.black

    init(model: ConnectionModel, showSheet: Binding<Bool>) {
        _showSheet = showSheet
        self.model = model
    }

    var body: some View {
        VStack(spacing: 64) {
            HStack {
                Spacer()

                Button("Close") {
                    showSheet = false
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                ColorPicker(
                    "Set the default off color", selection: $selectedColor
                ).onChange(
                    of: selectedColor,
                    perform: { color in
                        SettingsModel.shared.defaultColor = color
                        model.colorSubject.send(color.btColor)
                    }
                )

                Text("Set the default color the light will revert to. This is useful if you'd like to use your attention light as an actual lamp as well.")
                    .font(Font.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 8)

                Text("Use black to set the light to off when not attentioned.")
                    .font(Font.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 8)
            }

            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .onAppear {
            selectedColor = SettingsModel.shared.defaultColor
        }
    }
}
