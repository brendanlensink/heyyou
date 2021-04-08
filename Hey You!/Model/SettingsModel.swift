//
//  SettingsModel.swift
//  Hey You!
//
//  Created by Brendan on 2021-03-25.
//

import SwiftUI
import SwiftyUserDefaults
import UIKit

class SettingsModel {
    static let shared = SettingsModel()
    private init() {}
    
    var defaultColor: Color {
        get {
            Color(Defaults[\.defaultColor])
        }
        set {
            Defaults[\.defaultColor] = UIColor(newValue)
        }
    }
}
