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
        roundedRect.layer.borderColor = UIColor.systemBlue.withAlphaComponent(1).cgColor
        roundedRect.layer.cornerRadius = 9.6
        roundedRect.translatesAutoresizingMaskIntoConstraints = false
        return roundedRect
    }()
    
    
    
    private let label: LabelComponent = {
        let label = LabelComponent(text: "blebelbelbel sgssg ssgdfg sd sdggsdgsgdfgdgfgd sdgdfg fd dfgdgf", accessibilityLabel: "Start")
        label.textLabel.textAlignment = .left // Set text alignment as needed
        label.textLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textLabel.numberOfLines = 2
        label.textLabel.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = true
        

        return label
    }()
    
    init(timeLabel: String = "8:20", taskName: String = "Nome da tarefa do usuario testando o tamanho imagina uma task desse tamanho") {
        super.init(frame: .zero)
        
        let timeLabel: LabelComponent = {
            let timeLabel = LabelComponent(text: timeLabel, accessibilityLabel: timeLabel)
            timeLabel.textLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
            timeLabel.textLabel.adjustsFontSizeToFitWidth = false
            timeLabel.translatesAutoresizingMaskIntoConstraints = true
            
            return timeLabel
        }()
        
        horizontalStackView.addArrangedSubview(label)
        stackView.addArrangedSubview(timeLabel)
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
            
            timeLabel.bottomAnchor.constraint(equalTo: roundedRect.topAnchor, constant: -2),
            timeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 14)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview{
    SubtaskComponent()
}
