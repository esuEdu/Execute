//
//  SubtaskComponent.swift
//  DailyTask
//
//  Created by Luca on 04/10/23.
//

import Foundation
import UIKit

class SubtaskComponent: UIView {
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let roundedRect: UIView = {
        let roundedRect = UIView()
        roundedRect.backgroundColor = UIColor.systemBlue.withAlphaComponent(0)
        roundedRect.layer.cornerRadius = 10
        roundedRect.clipsToBounds = false
        roundedRect.layer.borderWidth = 3.5
        roundedRect.layer.borderColor = UIColor.systemBlue.withAlphaComponent(1).cgColor
        roundedRect.layer.cornerRadius = 9.6
        roundedRect.translatesAutoresizingMaskIntoConstraints = false
        return roundedRect
    }()
    
    private let frontCircle: UIImageView = {
        let circle = UIImageView()
        circle.image = UIImage(systemName: "circle")!
        circle.tintColor = .systemBlue
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()
    
    private let backCircle: UIImageView = {
        let circle = UIImageView()
        circle.image = UIImage(systemName: "circle.fill")!
        circle.tintColor = .black
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()
    
    private let label: LabelComponent = {
        let label = LabelComponent(text: "blebelbelbel sgdckdkn ncnk mkdmk mdkcm kdmcldm kmcdlk cldc dm lmd cmdl mckdm ssg ssgdfg sd sdggsdgsgdfgdgfgd sdgdfg fd dfgdgf", accessibilityLabel: "Start")
        label.textLabel.textAlignment = .left
        label.textLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textLabel.numberOfLines = 2
        label.textLabel.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = true
        label.textLabel.textColor = .white
        label.textLabel.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let roundedCheckbox: RoundedCheckbox = {
        let checkbox = RoundedCheckbox()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let secondLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    init(taskName: String = "Nome da tarefa do usuario testando o tamanho imagina uma task desse tamanho") {
        super.init(frame: .zero)
        roundedCheckbox.delegate = self
        horizontalStackView.addArrangedSubview(label)
        addSubview(view)
        addSubview(horizontalStackView)
        
        addSubview(roundedRect)
        addSubview(roundedCheckbox)
        
        addSubview(line)
        addSubview(secondLine)
        addSubview(backCircle)
        addSubview(frontCircle)
        
        
        let footnoteSize = (UIFont.preferredFont(forTextStyle: .footnote).lineHeight)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: (footnoteSize * 3.3) + 16),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.heightAnchor.constraint(equalTo: backCircle.heightAnchor),
            view.centerYAnchor.constraint(equalTo: roundedRect.centerYAnchor),
            view.trailingAnchor.constraint(equalTo: roundedRect.leadingAnchor, constant: -20),
            
            roundedRect.heightAnchor.constraint(equalToConstant: label.textLabel.font.lineHeight * 3.3),
            roundedRect.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            roundedRect.trailingAnchor.constraint(equalTo: roundedCheckbox.leadingAnchor, constant: -50),
            
            horizontalStackView.topAnchor.constraint(equalTo: roundedRect.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: roundedRect.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: roundedRect.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: roundedRect.bottomAnchor),
            
            roundedCheckbox.leadingAnchor.constraint(equalTo: roundedRect.trailingAnchor, constant: 50),
            roundedCheckbox.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedCheckbox.centerYAnchor.constraint(equalTo: roundedRect.centerYAnchor),
            
            backCircle.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            backCircle.widthAnchor.constraint(equalTo: backCircle.heightAnchor),
            backCircle.centerYAnchor.constraint(equalTo: roundedRect.centerYAnchor),
            backCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            frontCircle.heightAnchor.constraint(equalTo: backCircle.heightAnchor),
            frontCircle.widthAnchor.constraint(equalTo: frontCircle.heightAnchor),
            frontCircle.leadingAnchor.constraint(equalTo: backCircle.leadingAnchor),
            frontCircle.topAnchor.constraint(equalTo: backCircle.topAnchor),
            frontCircle.bottomAnchor.constraint(equalTo: backCircle.bottomAnchor),
            frontCircle.trailingAnchor.constraint(equalTo: backCircle.trailingAnchor),
            
            line.bottomAnchor.constraint(equalTo: backCircle.topAnchor, constant: 4),
            line.topAnchor.constraint(equalTo: topAnchor),
            line.heightAnchor.constraint(equalToConstant: ((footnoteSize * 3.3)/1.7) + 4) ,
            line.widthAnchor.constraint(equalToConstant: (footnoteSize * 3.3)/8.6),
            line.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            secondLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            secondLine.topAnchor.constraint(equalTo: backCircle.bottomAnchor, constant: -4),
            secondLine.heightAnchor.constraint(equalToConstant: ((footnoteSize * 3.3)/1.7) + 4) ,
            secondLine.widthAnchor.constraint(equalToConstant: (footnoteSize * 3.3)/8.6),
            secondLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SubtaskComponent: RoundedCheckboxDelegate{
    func buttonWasPressed(pressed: Bool) {
        if pressed{
            UIView.animate(withDuration: 0.2) {
                let attributedText = NSMutableAttributedString(string: self.label.textLabel.text!)
                attributedText.addAttribute(.strikethroughStyle, value: 2, range: NSRange(location: 0, length: self.label.textLabel.text!.count))
                
                self.label.textLabel.attributedText = attributedText
                self.label.textLabel.alpha = 0.4
                self.roundedRect.alpha = 0.4
                self.line.backgroundColor =  .systemBlue
                self.secondLine.backgroundColor =  .systemBlue
            }
        } else{
            UIView.animate(withDuration: 0.2) {
                let attributedText = NSMutableAttributedString(string: self.label.textLabel.text!)
                attributedText.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: attributedText.length))
                
                self.label.textLabel.attributedText = attributedText
                self.label.textLabel.alpha = 1
                self.roundedRect.alpha = 1
                self.line.backgroundColor = .white
                self.secondLine.backgroundColor = .white
            }
            
        }
    }
}

#Preview{
    SubtaskComponent()
}
