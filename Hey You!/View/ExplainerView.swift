//
//  ExplainerView.swift
//  Hey You!
//
//  Created by Brendan on 2021-04-06.
//

import SwiftUI

struct ExplainerView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 64) {
            HStack {
                Spacer()
                Button("Close") {
                    isPresented = false
                }
            }

            Text("What is this?")
                .font(.headline)

            VStack(alignment: .leading, spacing: 8) {
                Text("You'll need a special bluetooth enabled lightbulb for this to work.")

                Link(
                    "You can buy one here! (I don't make any money of these and am not associated with them in any way, they're just handy!",
                     destination: URL(string: "https://www.gearbest.com/smart-light-bulb/pp_230349.html")!
                )

                Text("Once you've got your lightbulb plugged in, this app should automatically detect and connect to it, and you can use it to send signals to people in other rooms!")
            }

            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
