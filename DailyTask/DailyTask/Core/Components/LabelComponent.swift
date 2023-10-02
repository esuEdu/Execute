//
//  LabelView.swift
//  DailyTask
//
//  Created by Eduardo on 27/09/23.
//

import Foundation
import UIKit


/// `LabelComponent` is a custom UIView subclass that combines a UILabel and a UIStackView.
/// It provides a convenient way to display a labeled text with customizable styling and accessibility settings.
///
/// Example usage:
///
/// ```swift
/// let labelComponent = LabelComponent(
///     frame: CGRect(x: 0, y: 0, width: 200, height: 50),
///     text: "Your Text",
///     backgroundColor: .blue,
///     accessibilityLabel: "Accessibility Label",
///     textColor: .white,
///     stackSpacing: 16
/// )
/// ```
///
/// - Note: You can customize the appearance and accessibility properties of the label component.
class LabelComponent: UIView {
    
    /// The UIStackView that contains the UILabel.
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return stackView
    }()
    
    /// The UILabel that displays the text.
    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.isAccessibilityElement = true
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    /// Initializes a new `LabelComponent`.
       ///
       /// - Parameters:
       ///   - frame: The frame for the `LabelComponent`.
       ///   - text: The text to display.
       ///   - backgroundColor: The background color of the `LabelComponent`.
       ///   - accessibilityLabel: The accessibility label for screen readers.
       ///   - textColor: The text color of the label.
       ///   - stackSpacing: The spacing between the label and the stack view.
    init(text : String, backgroundColor: UIColor = .clear, accessibilityLabel: String, textColor: UIColor = .label, font: UIFont.TextStyle = .body) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        // configure textLabel
        textLabel.text = text
        textLabel.textColor = textColor
        textLabel.accessibilityLabel = accessibilityLabel
        textLabel.accessibilityValue = text
        textLabel.font = .preferredFont(forTextStyle: font)
        
        
        // Add the textLabel to the stackView
        stackView.addArrangedSubview(textLabel)
        
        // Configure the stackView
        stackView.backgroundColor = backgroundColor
        stackView.layer.cornerRadius = 5
        //add stack to the view
        addSubview(stackView)
        
        //set contraints of stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
        ])

    }
    
    /// Required initializer that is not implemented for this class.
        ///
        /// - Parameter coder: The NSCoder used for encoding and decoding.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
