//
//  TextDescriptionComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 27/09/23.
//

import UIKit

protocol TextDescriptionComponentDelegate: AnyObject {
    func textFieldDidEndEditing()
    func textFieldDidBeginEditing()
}
/// This is the component to text description that have all the configurations like word limits, return dismiss and placeholder
///
///  ## How to use?
///
///  You can define the horizontal and vertical padding by change the variable `horizontalPadding` and `verticalPadding`. 
///
/// You can also change the text color by using the function `changeTextColor(textColor: UIColor)`.
///
/// After the use you can get the text by using the `getText()` function:
///
/// ```swift
/// let description = TextDescriptionComponent()
/// description.horizontalPadding = 10
/// description.verticalPadding = 14
/// let descriptionResult = description.getText() //This return a string
///```
class TextDescriptionComponent: UIView {
    
    weak var delegate: TextDescriptionComponentDelegate?

    var horizontalPadding: CGFloat?{
        didSet{
            addAllConstraints()
        }
    }
    var verticalPadding: CGFloat?{
        didSet{
            addAllConstraints()
        }
    }
    
    let descriptionBox: UITextView = {
        let description = UITextView()
      description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private var placeholderColor: UIColor = .lightGray
    
    private var textColor: UIColor = .lightGray
    
    #warning("Change the color")
    let placeholder: String = String(localized: "Enter the description here...")
    
    init(placeholderColor: UIColor, textColor: UIColor) {
        super.init(frame: .zero)
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        addSubview(descriptionBox)
        descriptionBox.backgroundColor = UIColor.clear
        descriptionBox.text = placeholder
        descriptionBox.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionBox.textColor = self.placeholderColor
        descriptionBox.delegate = self
        addAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Returns a string with the current text
    func getText() -> String{
        return descriptionBox.text == placeholder ? "" : descriptionBox.text
    }
    
    // Change the text color of the text
    func changeTextColor(textColor: UIColor){
        descriptionBox.textColor = placeholderColor
    }
    
    private func addAllConstraints(){
        NSLayoutConstraint.activate([
            descriptionBox.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            descriptionBox.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionBox.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionBox.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}

extension TextDescriptionComponent: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == placeholderColor {
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let maxCharactor = 200
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
    
}

#Preview(){
    TextDescriptionComponent(placeholderColor: .brown, textColor: .black)
}
