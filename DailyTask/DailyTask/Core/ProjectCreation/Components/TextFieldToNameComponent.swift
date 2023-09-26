//
//  File.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 25/09/23.
//

import UIKit

///
///
///
///
class TextFieldToName: UIView {
    #warning("Colocar o nslocalized")
    let textFieldToGetTheName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Dê um nome ao projeto"
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        addAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        self.textFieldToGetTheName.delegate = self
        backgroundColor = .systemIndigo
        layer.cornerRadius = 10
        addSubview(textFieldToGetTheName)
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            textFieldToGetTheName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            textFieldToGetTheName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            textFieldToGetTheName.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            textFieldToGetTheName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
//            textFieldToGetTheName.heightAnchor.constraint(equalToConstant: 30),
//            heightAnchor.constraint(equalTo: textFieldToGetTheName.heightAnchor)
        ])
    }
    
}

extension TextFieldToName: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxCharactor = 50
        
        let currentString :NSString = (textField.text ?? "") as NSString
        
        let newString: NSString = currentString.replacingCharacters (in: range, with: string) as NSString
        
        return newString.length <= maxCharactor
    }
}
