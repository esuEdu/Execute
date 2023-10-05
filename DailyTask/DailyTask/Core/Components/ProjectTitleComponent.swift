//
//  ProjectTitle.swift
//  DailyTask
//
//  Created by Eduardo on 04/10/23.
//

import Foundation
import UIKit

class ProjectTitleComponent: UIView {
    let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    init(projectTitle: String, color: UIColor) {
        super.init(frame: .zero)
        let label = LabelComponent(text: projectTitle, accessibilityLabel: projectTitle, textColor: UIColor.selectTheBestColor(color: color, isBackground: true),font: .title3)

        mainStack.backgroundColor = color
        mainStack.addArrangedSubview(label)
        
        
        
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
