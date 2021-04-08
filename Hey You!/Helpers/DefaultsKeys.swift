//
//  DefaultsKeys.swift
//  Hey You!
//
//  Created by Brendan on 2021-03-25.
//

import UIKit
import SwiftyUserDefaults

extension DefaultsKeys {
    var defaultColor: DefaultsKey<UIColor> { .init("defaultColor", defaultValue: UIColor.black) }
}
