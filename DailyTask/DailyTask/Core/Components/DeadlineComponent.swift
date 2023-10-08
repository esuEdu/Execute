//
//  DeadlineComponent.swift
//  DailyTask
//
//  Created by Eduardo on 28/09/23.
//

import UIKit

/// `DeadlineComponent` is a custom UIView subclass that provides a user interface for selecting start and end dates for a deadline.
///
/// Example usage:
///
/// ```swift
/// let deadlineComponent = DeadlineComponent()
/// ```
///
/// - Note: This component includes two date pickers for selecting start and end dates, along with labels to indicate their purpose.
class DeadlineComponent: UIView {
    
    /// The main stack view that contains all elements.
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
    
    /// The stack view for the start date section.
    private let startStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// The stack view for the end date section.
    private let endStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// The label for the start date.
    private let startLabel: LabelComponent = {
        let label = LabelComponent(text: String(localized: "StartDateLabel"), accessibilityLabel: "Start")
        return label
    }()
    
    /// The label for the end date.
    private let endLabel: LabelComponent = {
        let label = LabelComponent(text: String(localized: "EndDateLabel"), accessibilityLabel: "End")
        return label
    }()
    
    /// The date picker for selecting the start date.
    let startDatePicker: DatePickerComponent = {
        let datePicker = DatePickerComponent(datePickerStyle: .automatic, datePickerMode: .dateAndTime)
        datePicker.tintColor = .lightGray
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    /// The date picker for selecting the end date.
    let endDatePicker: DatePickerComponent = {
        let datePicker = DatePickerComponent(datePickerStyle: .automatic, datePickerMode: .dateAndTime)
        datePicker.tintColor = .lightGray
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    /// A separator line between the start and end date sections.
    let line: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    /// Initializes a new `DeadlineComponent`.
    init() {
        super.init(frame: .zero)
        
        // Configure the start date section
        startStackView.addArrangedSubview(startLabel)
        startStackView.addArrangedSubview(startDatePicker)
        
        // Add the start date section to the main stack
        stackView.addArrangedSubview(startStackView)
        
        // Add a separator line
        stackView.addArrangedSubview(line)
        
        // Configure the end date section
        endStackView.addArrangedSubview(endLabel)
        endStackView.addArrangedSubview(endDatePicker)
        
        // Add the end date section to the main stack
        stackView.addArrangedSubview(endStackView)
        
        // Add the main stack to the view
        self.addSubview(stackView)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            startStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            startStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            endStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            endStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.4),
            line.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    /// Required initializer that is not implemented for this class.
    ///
    /// - Parameter coder: The NSCoder used for encoding and decoding.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview{
    DeadlineComponent()
}
