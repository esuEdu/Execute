//
//  BreakableTextComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 02/10/23.
//

import UIKit

/// The `BreakableTextComponentDelegate` protocol defines methods for responding to changes in a `BreakableTextComponent`.
///
/// Implement this protocol in your custom classes to receive notifications when the text field begins or ends editing.
protocol BreakableTextComponentDelegate: AnyObject {
    /// Tells the delegate that the text field did end editing.
    func textFieldDidEndEditing()
    
    /// Tells the delegate that the text field did begin editing.
    func textFieldDidBeginEditing()
}


/// `BreakableTextComponent` is a custom UIView that provides a multi-line text input field with the ability to break text into multiple lines.
///
/// Example usage:
///
/// ```swift
/// let textComponent = BreakableTextComponent(placeholderColor: .systemGray2, textColor: .black)
/// textComponent.delegate = self
/// addSubview(textComponent)
/// ```
///
/// This component is useful for capturing input text that may need to span multiple lines, such as notes or descriptions.
class BreakableTextComponent: UIView {
    
    weak var delegate: BreakableTextComponentDelegate?
    
    var textViewHeightConstraint: NSLayoutConstraint!
    let placeholderColor: UIColor?
    let textColor: UIColor?
    let placeholder: String = String(localized: "Enter the subtask here...")
    let isFirtTime: Bool = false
    
    /// The UITextView used for input.
    private var textView: UITextView = {
        let description = UITextView()
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    /// Initializes a new `BreakableTextComponent` with the specified placeholder and text colors.
    ///
    /// - Parameters:
    ///   - placeholderColor: The color of the placeholder text.
    ///   - textColor: The color of the input text.
    init(placeholderColor: UIColor, textColor: UIColor) {
        self.placeholderColor = placeholderColor
        self.textColor = textColor
        super.init(frame: .zero)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.isEditable = true
        textView.textContainer.maximumNumberOfLines = 2
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.text = placeholder
        textView.textColor = placeholderColor
        textView.isUserInteractionEnabled = true

        addSubview(textView)
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: centerYAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.topAnchor.constraint(equalTo: topAnchor),
        ])
        
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: textView.font?.lineHeight ?? 30)
        textViewHeightConstraint.isActive = true
    }
    
    /// Gets the text entered in the component.
    ///
    /// - Returns: The entered text.
    func getText() -> String {
        return textView.text
    }
    
    func changeBgColor(color: UIColor){
        textView.backgroundColor = color
    }
    
    /// Required initializer that is not implemented for this class.
    ///
    /// - Parameter coder: The NSCoder used for encoding and decoding.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BreakableTextComponent: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.bounds.width, height: .infinity)
        let newSize = textView.sizeThatFits(size)
        let maxHeight: CGFloat = (textView.font?.lineHeight ?? 100) * 2
        textViewHeightConstraint.constant = min(newSize.height, maxHeight)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let maxCharactor = 80
        let currentString: NSString = textView.text as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
        
        if range.location == 0 && text == " " {
            return false
        }
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return newString.length <= maxCharactor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder && textView.textColor == placeholderColor {
            textView.text = ""
            textView.textColor = textColor
        }
        delegate?.textFieldDidBeginEditing()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeholder
            textView.textColor = placeholderColor
        }
        delegate?.textFieldDidEndEditing()
    }
}

