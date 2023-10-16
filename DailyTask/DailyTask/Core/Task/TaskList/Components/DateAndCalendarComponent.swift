//
//  DateAndCalendarComponent.swift
//  DailyTask
//
//  Created by Eduardo on 05/10/23.
//

import Foundation
import UIKit

class DateAndCalendarComponent: UIView {
    let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor(.customPrimaryBlue)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 9, left: 20, bottom: 9, right: 20)
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = UIColor(.customCalendar)
        return button
    }()
    
    var dateLabel: LabelComponent?
    
    init(date: String) {
        super.init(frame: .zero)
        let dateLabel = LabelComponent(text: date, accessibilityLabel: date,textColor: .white)
        dateLabel.textLabel.font = .boldTitle2
        self.dateLabel = dateLabel
        mainStack.addArrangedSubview(dateLabel)
        mainStack.addArrangedSubview(button)
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
