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
        stackView.distribution = .equalSpacing
      stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let icon: ChooseIconComponent = {
        let icon = ChooseIconComponent()
      icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let texts: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
      stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(titleTask: String, timeLabel: String) {
        super.init(frame: .zero)
      
      self.backgroundColor = .systemGray2
        
        let titleLabel = LabelComponent(text: titleTask, accessibilityLabel: titleTask)
        
        let timeLabel = LabelComponent(text: "Start at \(timeLabel)", accessibilityLabel: "Start at \(timeLabel)")
      
      self.addSubview(mainStack)
      
      texts.addArrangedSubview(titleLabel)
      texts.addArrangedSubview(timeLabel)
        
        mainStack.addArrangedSubview(icon)
        mainStack.addArrangedSubview(texts)
        
        NSLayoutConstraint.activate([
          mainStack.topAnchor.constraint(equalTo: self.topAnchor),
          mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
          mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
          mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

