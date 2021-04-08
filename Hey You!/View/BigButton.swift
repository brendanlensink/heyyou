//
//  BigButton.swift
//  Hey You!
//
//  Created by Brendan on 2021-03-24.
//

import Combine
import SwiftUI

enum ButtonSize {
    case big
    case small

    var height: CGFloat {
        switch self {
        case .big: return 250
        case .small: return 125
        }
    }

    var textSize: CGFloat {
        switch self {
        case .big: return 50
        case .small: return 24
        }
    }

    var textOffsetDown: CGFloat {
        switch self {
        case .big: return -18
        case .small: return -8
        }
    }

    var textOffsetUp: CGFloat {
        switch self {
        case .big: return -44
        case .small: return -28
        }
    }
}

struct BigButton: View {
    @State private var isSelected: Bool = false

    let color: Color
    let size: ButtonSize
    let text: String
    let colorSubject: PassthroughSubject<BTColor, Never>

    init(color: Color, size: ButtonSize, text: String, colorSubject: PassthroughSubject<BTColor, Never>) {
        self.color = color
        self.colorSubject = colorSubject
        self.size = size
        self.text = text
    }

    var body: some View {
        Button(
            action: {}, label: {
                if isSelected {
                    ButtonDown(color: color, size: size, text: text)
                } else {
                    ButtonUp(color: color, size: size, text: text)
                }
            }
        ).buttonStyle(PlainButtonStyle())
        .onTouchDownGesture(
            onTap: {
                colorSubject.send(color.btColor)
                self.isSelected = true
            },
            onEnd: {
                colorSubject.send(SettingsModel.shared.defaultColor.btColor)
                self.isSelected = false
            }
        )
    }
}

extension View {
    func onTouchDownGesture(onTap: @escaping () -> Void, onEnd: @escaping () -> Void) -> some View {
        modifier(OnTouchDownGestureModifier(onTap: onTap, onEnd: onEnd))
    }
}

private struct OnTouchDownGestureModifier: ViewModifier {
    @State private var tapped = false
    let onTap: () -> Void
    let onEnd: () -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    if !self.tapped {
                        self.tapped = true
                        self.onTap()
                    }
                }
                .onEnded { _ in
                    self.tapped = false
                    self.onEnd()
                })
    }
}
