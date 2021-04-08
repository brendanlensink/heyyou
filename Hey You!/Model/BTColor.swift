//
//  BTColor.swift
//  Hey You!
//
//  Created by Brendan on 2021-03-24.
//

import SwiftUI

struct BTColor: Equatable {
    let r: UInt8
    let g: UInt8
    let b: UInt8

    var color: Color {
        Color(.sRGB, red: Double(r), green: Double(g), blue: Double(b), opacity: 1)
    }

    // TODO: consider letting people set the default 'off' state to something other than light off ie: regular color for an actual lamp
    static let off = BTColor(r: 0x00, g: 0x00, b: 0x00)
    static let red = BTColor(r: 0xFF, g: 0x00, b: 0x00)
    static let green = BTColor(r: 0x00, g: 0xFF, b: 0x00)
    static let purple = BTColor(r: 0x80, g: 0x00, b: 0x80)
    static let yellow = BTColor(r: 0xFF, g: 0xFF, b: 0x00)
    static let orange = BTColor(r: 0xFF, g: 0x85, b: 0x00)
    static let pink = BTColor(r: 0xE8, g: 0x00, b: 0xCA)
}

extension Color {
    var btColor: BTColor {
        return BTColor(
            r: self.components.red,
            g: self.components.green,
            b: self.components.blue
        )
    }
}

extension Color {
    var components: (red: UInt8, green: UInt8, blue: UInt8, opacity: UInt8) {

        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            return (0, 0, 0, 0)
        }

        return (UInt8(r * 255), UInt8(g * 255), UInt8(b * 255), UInt8(o * 255))
    }
}
