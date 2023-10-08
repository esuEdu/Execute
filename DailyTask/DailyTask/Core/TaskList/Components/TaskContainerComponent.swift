//
//  TaskContainerComponent.swift
//  DailyTask
//
//  Created by Eduardo on 02/10/23.
//

import Foundation
import UIKit

class TaskContainerComponent: UIView {
    
    let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false        
        stackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner]
        stackView.clipsToBounds = true
        return stackView
    }()
    
    let timeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 10
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 13, bottom: 3, right: 13)
        return stackView
    }()
    
    let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        return stackView
    }()
    
    init(timeLabel: String = "8:20", taskName: String = "Nome da tarefa do usuario testando o tamanho imagina uma task desse tamanho") {
        super.init(frame: .zero)
        
        let timeLabel = LabelComponent(text: timeLabel, accessibilityLabel: timeLabel, font: .caption1)
        
        let taskName = LabelComponent(text: taskName, accessibilityLabel: taskName, font: .footnote, numberOfLines: 2 ,lineBreakMode: .byTruncatingTail)
        
        timeStack.addArrangedSubview(timeLabel)
        
        containerStack.addArrangedSubview(taskName)
        

                
        mainStack.addArrangedSubview(containerStack)
        
        addSubview(timeStack)
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            timeStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.topAnchor.constraint(equalTo: timeStack.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
