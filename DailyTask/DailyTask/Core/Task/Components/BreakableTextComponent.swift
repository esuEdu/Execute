//
//  BreakableTextComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 02/10/23.
//

import UIKit

protocol BreakableTextComponentDelegate: AnyObject {
    func textFieldDidEndEditing()
    func textFieldDidBeginEditing()
}

class BreakableTextComponent: UIView {
    
    weak var delegate: BreakableTextComponentDelegate?

    var textViewHeightConstraint: NSLayoutConstraint!
    let placeholderColor: UIColor?
    let textColor: UIColor?
    let placeholder: String = String(localized: "Enter the subtask here...")
    let isFirtTime: Bool = false
    
    private var textView: UITextView = {
        let description = UITextView()
      description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    init(placeholderColor: UIColor, textColor: UIColor){
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
    
    func getText() -> String{
        return textView.text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BreakableTextComponent: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.bounds.width, height: .infinity)
        let newSize = textView.sizeThatFits(size)
        let maxHeight: CGFloat = (textView.font?.lineHeight ?? 100) * 2
        textViewHeightConstraint.constant = min(newSize.height, maxHeight)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let maxCharactor = 80
        let currentString: NSString = textView.text as NSString
        let newString: NSString = currentString.replacingCharacters (in: range, with: text) as NSString
        
        
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

#Preview{
    BreakableTextComponent(placeholderColor: .systemGray2, textColor: .black)
}
