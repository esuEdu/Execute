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
    
    /// The stack view for the time label and task name.
    let timeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 10
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 13)
        return stackView
    }()
    
    /// The stack view for the task name label.
    let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 12, bottom: 3, right: 12)
        stackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return stackView
    }()
    
    let roundedCheckbox: RoundedCheckbox = {
        let checkbox = RoundedCheckbox()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    var progressBar: CircularProgressView?
    
    let labelPercent: UILabel = {
        let label = UILabel()
        label.text = "100%"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .caption1).lineHeight, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let line: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .systemBlue
        return line
    }()
    
    
    
    var taskName: LabelComponent?
    
    /// Initializes a new `TaskContainerComponent`.
    ///
    /// - Parameters:
    ///   - timeLabel: The time label to display.
    ///   - taskName: The task name to display.
    init(timeLabel: String = "8:20", taskName: String = "Sample task ljnsjdnjs n dfmd fm ndjnfjdn fjndjfndjn jkndjnfj dkn fjkdnkj nfdjknf jd") {
        super.init(frame: .zero)
        
        progressBar = CircularProgressView(lineWidth: labelPercent.font.lineHeight/3.5)
        progressBar!.setProgress(0.5)
        progressBar!.translatesAutoresizingMaskIntoConstraints = false
        
        roundedCheckbox.delegate = self
        
        // Create and configure time label
        let timeLabel = LabelComponent(text: timeLabel, accessibilityLabel: timeLabel, font: .caption1)
        
        // Create and configure task name label
        self.taskName = LabelComponent(text: taskName, accessibilityLabel: taskName, font: .footnote, numberOfLines: 2, lineBreakMode: .byTruncatingTail)
        
        // Add time label to the time stack
        timeStack.addArrangedSubview(timeLabel)
        
        containerStack.addArrangedSubview(self.taskName!)
        addSubview(containerStack)
        addSubview(roundedCheckbox)
        
        // Add time stack and main stack to the view
        addSubview(timeStack)
        
        addSubview(progressBar!)
        addSubview(line)
        addSubview(labelPercent)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            timeStack.topAnchor.constraint(equalTo: topAnchor),
            timeStack.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor),
            timeStack.heightAnchor.constraint(equalTo: timeLabel.heightAnchor, constant: 4),
            
            containerStack.topAnchor.constraint(equalTo: timeStack.bottomAnchor),
            containerStack.leadingAnchor.constraint(equalTo: progressBar!.trailingAnchor, constant: 20),
            containerStack.trailingAnchor.constraint(equalTo: roundedCheckbox.leadingAnchor, constant: -20),
            containerStack.bottomAnchor.constraint(equalTo: line.topAnchor),
            containerStack.heightAnchor.constraint(equalToConstant: self.taskName!.textLabel.font.lineHeight * 3.3),
            
            roundedCheckbox.leadingAnchor.constraint(equalTo: containerStack.trailingAnchor, constant: 20),
            roundedCheckbox.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedCheckbox.centerYAnchor.constraint(equalTo: containerStack.centerYAnchor),
            
            progressBar!.topAnchor.constraint(equalTo: containerStack.topAnchor, constant: -16),
            progressBar!.bottomAnchor.constraint(equalTo: containerStack.bottomAnchor),
            progressBar!.widthAnchor.constraint(equalTo: progressBar!.heightAnchor),
            progressBar!.trailingAnchor.constraint(equalTo: containerStack.leadingAnchor, constant: -20),
            progressBar!.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            labelPercent.leadingAnchor.constraint(equalTo: progressBar!.leadingAnchor),
            labelPercent.trailingAnchor.constraint(equalTo: progressBar!.trailingAnchor),
            labelPercent.topAnchor.constraint(equalTo: progressBar!.topAnchor),
            labelPercent.bottomAnchor.constraint(equalTo: progressBar!.bottomAnchor),
            labelPercent.centerYAnchor.constraint(equalTo: progressBar!.centerYAnchor),
            labelPercent.centerXAnchor.constraint(equalTo: progressBar!.centerXAnchor),
            
            line.topAnchor.constraint(equalTo: containerStack.bottomAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: (self.taskName!.textLabel.font.lineHeight * 3.3)/2),
            line.widthAnchor.constraint(equalToConstant: (self.taskName!.textLabel.font.lineHeight * 3.3)/8.6),
            line.centerXAnchor.constraint(equalTo: progressBar!.centerXAnchor),
            
        ])
    }
    
    /// Required initializer that is not implemented for this class.
    ///
    /// - Parameter coder: The NSCoder used for encoding and decoding.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskContainerComponent: RoundedCheckboxDelegate{
    func buttonWasPressed(pressed: Bool) {
        if pressed{
            let attributedText = NSMutableAttributedString(string: taskName!.textLabel.text!)
            attributedText.addAttribute(.strikethroughStyle, value: 2, range: NSRange(location: 0, length: taskName!.textLabel.text!.count))
            
            taskName!.textLabel.attributedText = attributedText
            taskName!.textLabel.alpha = 0.4
            progressBar?.setProgress(1)
            labelPercent.text = "\(100)%"
            line.backgroundColor = .systemBlue
            layoutIfNeeded()
        } else{
            let attributedText = NSMutableAttributedString(string: taskName!.textLabel.text!)
            attributedText.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: attributedText.length))
            
            taskName!.textLabel.attributedText = attributedText
            taskName!.textLabel.alpha = 1
            progressBar?.setProgress(0)
            labelPercent.text = "\(0)%"
            line.backgroundColor = .white
            line.alpha = 1
            layoutIfNeeded()
        }
    }
}

#Preview{
    TaskContainerComponent()
}
