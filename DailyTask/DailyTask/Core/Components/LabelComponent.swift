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
/// ## Example Usage
///
/// ```swift
/// let labelComponent = LabelComponent(
///     text: "Your Text",
///     backgroundColor: .blue,
///     accessibilityLabel: "Accessibility Label",
///     textColor: .white,
///     font: .body,
///     numberOfLines: 0,
///     lineBreakMode: .byWordWrapping
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
  ///   - text: The text to display.
  ///   - backgroundColor: The background color of the `LabelComponent`.
  ///   - accessibilityLabel: The accessibility label for screen readers.
  ///   - textColor: The text color of the label.
  ///   - font: The font style for the label text.
  ///   - numberOfLines: The maximum number of lines for the label text.
  ///   - lineBreakMode: The line break mode for the label text.
  init(text: String, backgroundColor: UIColor = .clear, accessibilityLabel: String, textColor: UIColor = .label, font: UIFont.TextStyle = .body, numberOfLines: Int = 0, lineBreakMode: NSLineBreakMode = .byWordWrapping) {
      super.init(frame: .zero)
    
    // Configure textLabel
    textLabel.text = text
    textLabel.textColor = textColor
    textLabel.accessibilityLabel = accessibilityLabel
    textLabel.accessibilityValue = text
    textLabel.font = .preferredFont(forTextStyle: font)
    textLabel.numberOfLines = numberOfLines
    textLabel.lineBreakMode = lineBreakMode
    textLabel.adjustsFontSizeToFitWidth = false
    
    // Add the textLabel to the stackView
    stackView.addArrangedSubview(textLabel)
    
    // Configure the stackView
    stackView.backgroundColor = backgroundColor
    stackView.layer.cornerRadius = 5
    
    // Add stackView to the view
    addSubview(stackView)
    
    // Set constraints of stackView
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
