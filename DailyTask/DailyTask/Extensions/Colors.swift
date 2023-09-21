//
//  Colors.swift
//  DailyTask
//
//  Created by Eduardo on 20/09/23.
//

import Foundation
import UIKit

enum CustomColor {
    case customRed
    case customGreen
    case customBlue
    // Add more color cases as needed
}

extension UIColor {
    convenience init?(_ customColor: CustomColor) {
        switch customColor {
        case .customRed:
            self.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case .customGreen:
            self.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        case .customBlue:
            self.init(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
            // Add more cases and color values as needed
        }
    }
}
