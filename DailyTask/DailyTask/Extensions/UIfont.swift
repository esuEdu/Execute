//
//  UIfont.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 04/10/23.
//

import Foundation
import UIKit

/// An extension for `UIFont` that provides a convenience method for creating a bold font
/// with the same point size as the system's preferred font for `.title1` text style.
///
/// ## Example Usage
///
/// ```swift
/// let boldTitleFont = UIFont.boldTitle1
/// ```
///
/// - Note: This extension simplifies the process of creating a bold font with the same size
///         as the system's preferred `.title1` font.
extension UIFont {
    
    /// Returns a bold font with the same point size as the system's preferred font for `.title1` text style.
    static var boldTitle1: UIFont {
        return UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
}
