//
//  ButtonDown.swift
//  Hey You!
//
//  Created by Brendan on 2021-04-06.
//

import SwiftUI

struct ButtonDown: View {
    let color: Color
    let size: ButtonSize
    let text: String

    var body: some View {
        ZStack {
            Image("button_base")
                .resizable()
            
            Image("button_down_bottom")
                .resizable()
                .foregroundColor(color)
                .brightness(-0.5)

            Image("button_down_top")
                .resizable()
                .foregroundColor(color)

            Text(text)
                .font(Font.custom("RobotoCondensed-Bold", size: size.textSize))
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .rotation3DEffect(.degrees(20), axis: (x: 1, y: 0, z: 0))
                .offset(x: 0, y: size.textOffsetDown)
                .frame(width: size.height * 0.8, alignment: .center)
        }.frame(width: size.height, height: size.height)
    }
}

