//
//  SubtaskComponent.swift
//  DailyTask
//
//  Created by Luca on 04/10/23.
//

import Foundation
import UIKit

class SubtaskComponent: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let roundedRect: UIView = {
        let roundedRect = UIView()
        roundedRect.backgroundColor = UIColor.systemBlue.withAlphaComponent(0)
        roundedRect.layer.cornerRadius = 10
        roundedRect.clipsToBounds = false
        roundedRect.layer.borderWidth = 3.5
        roundedRect.layer.borderColor = UIColor.lightGray.cgColor
        roundedRect.layer.cornerRadius = 9.6
        roundedRect.translatesAutoresizingMaskIntoConstraints = false
        return roundedRect
    }()
    
    private let label: LabelComponent = {
        let label = LabelComponent(text: "blebelbelbel sgssg ssgdfg sd sdggsdgsgdfgdgfgd sdgdfg fd dfgdgf", accessibilityLabel: "Start")
        label.tintColor = UIColor.red
        label.textLabel.textAlignment = .left // Set text alignment as needed
        label.textLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textLabel.numberOfLines = 2
        label.textLabel.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = true
        

        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        horizontalStackView.addArrangedSubview(label)
        stackView.addArrangedSubview(horizontalStackView)
        
        stackView.addArrangedSubview(roundedRect)
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            roundedRect.widthAnchor.constraint(equalToConstant: 220),
            roundedRect.heightAnchor.constraint(equalToConstant: 52),
            roundedRect.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedRect.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            label.topAnchor.constraint(equalTo: roundedRect.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: roundedRect.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: roundedRect.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: roundedRect.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview{
    SubtaskComponent()
}
