//
//  AllTaskListComponts.swift
//  DailyTask
//
//  Created by Eduardo on 05/10/23.
//

import Foundation
import UIKit

class AllTaskListComponts: UIView {
    
    let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor.red
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let icon: ChooseIconComponent = {
        let icon = ChooseIconComponent()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let roundedCheckbox: RoundedCheckbox = {
        let roundedCheckbox = RoundedCheckbox()
        roundedCheckbox.layer.zPosition = 10
        roundedCheckbox.translatesAutoresizingMaskIntoConstraints = false
        return roundedCheckbox
    }()
    
    let texts: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let stackCheckbox: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(titleTask: String, timeLabel: String) {
        super.init(frame: .zero)
        
        let titleLabel = LabelComponent(text: titleTask, accessibilityLabel: titleTask)
        
        let timeLabel = LabelComponent(text: "Start at \(timeLabel)", accessibilityLabel: "Start at \(timeLabel)")
    
        self.addSubview(mainStack)
        
        texts.addArrangedSubview(titleLabel)
        texts.addArrangedSubview(timeLabel)
        
        stackCheckbox.addArrangedSubview(roundedCheckbox)
        
        mainStack.addArrangedSubview(icon)
        mainStack.addArrangedSubview(texts)
        mainStack.addArrangedSubview(stackCheckbox)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            icon.heightAnchor.constraint(equalToConstant: 50),
            icon.widthAnchor.constraint(equalToConstant: 50),
            roundedCheckbox.heightAnchor.constraint(greaterThanOrEqualTo: roundedCheckbox.heightAnchor, multiplier: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

