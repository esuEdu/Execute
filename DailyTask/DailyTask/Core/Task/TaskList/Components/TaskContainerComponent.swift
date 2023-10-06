//
//  TaskContainerComponent.swift
//  DailyTask
//
//  Created by Eduardo on 02/10/23.
//

import UIKit

/// `TaskContainerComponent` is a custom UIView subclass that displays a task container with a time label and task name.
///
/// Example usage:
///
/// ```swift
/// let taskContainer = TaskContainerComponent(timeLabel: "8:20", taskName: "Sample task description")
/// ```
///
/// - Note: This component includes a time label and a task name label.
class TaskContainerComponent: UIView {
    
    /// The main stack view that contains all elements.
    let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 10
        stackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        stackView.clipsToBounds = true
        return stackView
    }()
    
    /// The stack view for the time label and task name.
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
    
    /// The stack view for the task name label.
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
    
    /// Initializes a new `TaskContainerComponent`.
    ///
    /// - Parameters:
    ///   - timeLabel: The time label to display.
    ///   - taskName: The task name to display.
    init(timeLabel: String = "8:20", taskName: String = "Sample task description") {
        super.init(frame: .zero)
        
        // Create and configure time label
        let timeLabel = LabelComponent(text: timeLabel, accessibilityLabel: timeLabel, font: .caption1)
        
        // Create and configure task name label
        let taskName = LabelComponent(text: taskName, accessibilityLabel: taskName, font: .footnote, numberOfLines: 2, lineBreakMode: .byTruncatingTail)
        
        // Add time label to the time stack
        timeStack.addArrangedSubview(timeLabel)
        
        // Add task name label to the container stack
        containerStack.addArrangedSubview(taskName)
        
        // Add container stack to the main stack
        mainStack.addArrangedSubview(containerStack)
        
        // Add time stack and main stack to the view
        addSubview(timeStack)
        addSubview(mainStack)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            timeStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.topAnchor.constraint(equalTo: timeStack.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    /// Required initializer that is not implemented for this class.
    ///
    /// - Parameter coder: The NSCoder used for encoding and decoding.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
