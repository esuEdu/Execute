//
//  TextFieldView.swift
//  DailyTask
//
//  Created by Eduardo on 26/09/23.
//

import Foundation
import UIKit

class TextView: UITextView, UITextViewDelegate {
    
    var placeholder: String!
    var placeholderColor: UIColor = .lightGray
    
    init(placeholder: String, placeholderColor: UIColor = .lightGray) {
        super.init(frame: .zero, textContainer: nil)
        
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .white
        
        setupPlaceholder()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupPlaceholder() {
        text = placeholder
        textColor = placeholderColor
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if text == placeholder {
            text = ""
            textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if text.isEmpty {
            setupPlaceholder()
        }
    }
}

#Preview {
    TextView(placeholder: "abs")
}
