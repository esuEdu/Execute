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
        return stackView
    }()
    
    let icon: ChooseIconComponent = {
        let icon = ChooseIconComponent()
        return icon
    }()
    
    let texts: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    init(titleTask: String, timeLabel: String) {
        super.init(frame: .zero)
        
        let titleLabel = LabelComponent(text: titleTask, accessibilityLabel: titleTask)
        
        let timeLabel = LabelComponent(text: "Start at \(timeLabel)", accessibilityLabel: "Start at \(timeLabel)")
        
        texts.addArrangedSubview(titleLabel)
        texts.addArrangedSubview(timeLabel)
        
        mainStack.addArrangedSubview(icon)
        mainStack.addArrangedSubview(texts)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

