//
//  TextDescriptionComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 27/09/23.
//

import UIKit

class TextDescriptionComponent: UIView {

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
    
    private let descriptionBox: UITextView = {
        let description = UITextView()
      description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    #warning("NSLocalized and change the color")
    let placeholder: String = "Digite a descrição aqui..."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(descriptionBox)
        descriptionBox.text = placeholder
        descriptionBox.textColor = .lightGray
        descriptionBox.delegate = self
        addAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getText() -> String{
        return descriptionBox.text == placeholder ? "" : descriptionBox.text
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
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let maxCharactor = 350
        let currentString: NSString = textView.text as NSString
        let newString: NSString = currentString.replacingCharacters (in: range, with: text) as NSString
        
        
        if range.location == 0 && text == " " {
            return false
        }
        
        if text == "\n" {
            textView.resignFirstResponder() // Oculta o teclado quando o usuário pressiona "Return"
            return false
        }
        
        return newString.length <= maxCharactor
    }
    
}

#Preview(){
    TextDescriptionComponent()
}
