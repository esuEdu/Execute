//
//  DeadlineComponent.swift
//  DailyTask
//
//  Created by Eduardo on 28/09/23.
//

import Foundation
import UIKit

class DeadlineComponent: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let startStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let endStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let startlabel: LabelComponent = {
        let label = LabelComponent(text: String(localized: "StartDateLabel"), accessibilityLabel: "Start")
        return label
    }()
    
    private let endlabel: LabelComponent = {
        let label = LabelComponent(text: String(localized: "EndDateLabel"), accessibilityLabel: "End")
        return label
    }()
    
    let startDatePicker: DatePickerComponent = {
        let datePicker = DatePickerComponent(datePickerStyle: .automatic, datePickerMode: .dateAndTime)
        datePicker.tintColor = .lightGray
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let endDatePicker: DatePickerComponent = {
        let datePicker = DatePickerComponent(datePickerStyle: .automatic, datePickerMode: .dateAndTime)
        datePicker.tintColor = .lightGray
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let line: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    init() {
        super.init(frame: .zero)
        
        startStackView.addArrangedSubview(startlabel)
        startStackView.addArrangedSubview(startDatePicker)
        
        stackView.addArrangedSubview(startStackView)
        stackView.addArrangedSubview(line)
        
        endStackView.addArrangedSubview(endlabel)
        endStackView.addArrangedSubview(endDatePicker)
        
        stackView.addArrangedSubview(endStackView)
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            endDatePicker.widthAnchor.constraint(equalToConstant: endDatePicker.frame.width * 0.75),
//            startDatePicker.widthAnchor.constraint(equalToConstant: startDatePicker.frame.width * 0.75),
            startStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            startStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            endStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            endStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.4),
            line.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview{
    DeadlineComponent()
}
