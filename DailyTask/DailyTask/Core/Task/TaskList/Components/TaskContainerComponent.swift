//
//  TaskContainerComponent.swift
//  DailyTask
//
//  Created by Eduardo on 02/10/23.
//

import UIKit

protocol TaskContainerComponentDelegate: AnyObject{
    func valueChanged() -> CGFloat
    func itWasPressed()
    func wasChecked(_ check: Bool)
}

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
    
    weak var delegate: TaskContainerComponentDelegate?
    
    /// The stack view for the time label and task name.
    let timeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 8
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        return stackView
    }() 
    
    let priorityStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 8
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return stackView
    }()
    
    /// The stack view for the task name label.
    let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .progressLine
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 9, bottom: 3, right: 9)
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
        label.text = "0%"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .caption1).lineHeight, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let line: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
//        line.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        line.backgroundColor = .completeProgressLine
        return line
    }()
    
    
    var taskName: LabelComponent?
    
    var touch: UITapGestureRecognizer?
    
    /// Initializes a new `TaskContainerComponent`.
    ///
    /// - Parameters:
    ///   - timeLabel: The time label to display.
    ///   - taskName: The task name to display.
    init(timeLabel: String = "18:20", taskName: String = "Sample task ljnsjdnjs n dfmd fm ndjnfjdn fjndjfndjn jkndjnfj dkn fjkdnkj nfdjknf jd", mainColor: UIColor = .completeProgressLine, priority: String = "!!!", isPressed: Bool) {
        super.init(frame: .zero)
        
       
        
        touch = UITapGestureRecognizer(target: self, action: #selector(taskIsPressed))
        
        containerStack.addGestureRecognizer(touch!)
        
        if self.traitCollection.userInterfaceStyle == .dark{
            containerStack.backgroundColor = mainColor.withAlphaComponent(0.45)
        } else{
            containerStack.backgroundColor = mainColor.withAlphaComponent(0.2)
        }
        
        timeStack.backgroundColor = mainColor
        
        labelPercent.textColor = UIColor.selectTheBestColor(color: mainColor, isBackground: true)
        
        progressBar = CircularProgressView(lineWidth: labelPercent.font.lineHeight/3.5, color: mainColor)
        progressBar!.setProgress(0)
        progressBar!.translatesAutoresizingMaskIntoConstraints = false
        
        roundedCheckbox.delegate = self
        
        roundedCheckbox.checked = isPressed
        
        // Create and configure time label
        let timeLabel = LabelComponent(text: timeLabel, accessibilityLabel: timeLabel, font: .caption1)
        let priorityLabel = LabelComponent(text: priority, accessibilityLabel: priority, font: .caption1)
        priorityLabel.textLabel.textAlignment = .right
        
        // Create and configure task name label
        self.taskName = LabelComponent(text: taskName, accessibilityLabel: taskName, font: .footnote, numberOfLines: 2, lineBreakMode: .byTruncatingTail)
        
        self.taskName?.textLabel.textColor = .label
        timeLabel.textLabel.textColor = UIColor.selectTheBestColor(color: mainColor, isBackground: true)
        
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
            
            timeStack.heightAnchor.constraint(equalTo: timeLabel.heightAnchor, constant: 5),
            
            containerStack.topAnchor.constraint(equalTo: timeStack.bottomAnchor),
            containerStack.leadingAnchor.constraint(equalTo: progressBar!.trailingAnchor, constant: 15),
            containerStack.trailingAnchor.constraint(equalTo: roundedCheckbox.leadingAnchor, constant: -15),
            containerStack.bottomAnchor.constraint(equalTo: line.topAnchor, constant: -6),
            containerStack.heightAnchor.constraint(equalToConstant: self.taskName!.textLabel.font.lineHeight * 3.3),
            
            roundedCheckbox.leadingAnchor.constraint(equalTo: containerStack.trailingAnchor, constant: 15),
            roundedCheckbox.trailingAnchor.constraint(equalTo: trailingAnchor),
            roundedCheckbox.centerYAnchor.constraint(equalTo: containerStack.centerYAnchor),
            
            progressBar!.topAnchor.constraint(equalTo: containerStack.topAnchor, constant: -16),
            progressBar!.bottomAnchor.constraint(equalTo: containerStack.bottomAnchor),
            progressBar!.widthAnchor.constraint(equalTo: progressBar!.heightAnchor),
            progressBar!.trailingAnchor.constraint(equalTo: containerStack.leadingAnchor, constant: -15),
            progressBar!.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            labelPercent.leadingAnchor.constraint(equalTo: progressBar!.leadingAnchor),
            labelPercent.trailingAnchor.constraint(equalTo: progressBar!.trailingAnchor),
            labelPercent.topAnchor.constraint(equalTo: progressBar!.topAnchor),
            labelPercent.bottomAnchor.constraint(equalTo: progressBar!.bottomAnchor),
            labelPercent.centerYAnchor.constraint(equalTo: progressBar!.centerYAnchor),
            labelPercent.centerXAnchor.constraint(equalTo: progressBar!.centerXAnchor),
            
            line.topAnchor.constraint(equalTo: containerStack.bottomAnchor, constant: 6),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: (self.taskName!.textLabel.font.lineHeight * 3.3)/2),
            line.widthAnchor.constraint(equalToConstant: (self.taskName!.textLabel.font.lineHeight * 3.3)/8.6),
            line.centerXAnchor.constraint(equalTo: progressBar!.centerXAnchor),
            
            
        ])
        
        if priority != "!!!"{
            
            switch(priority){
            case Priority.noPriority.rawValue:
                priorityStack.alpha = 0
            case Priority.low.rawValue:
                priorityStack.backgroundColor = mainColor.withAlphaComponent(0.3)
                priorityLabel.textLabel.text = "!"
            case Priority.medium.rawValue:
                priorityStack.backgroundColor = mainColor.withAlphaComponent(0.55)
                priorityLabel.textLabel.text = "!!"
            case Priority.high.rawValue:
                priorityStack.backgroundColor = mainColor.withAlphaComponent(1)
                priorityLabel.textLabel.textColor = UIColor.selectTheBestColor(color: mainColor, isBackground: true)
                priorityLabel.textLabel.text = "!!!"
            default:
                priorityStack.alpha = 0
            }
            
            priorityStack.addArrangedSubview(priorityLabel)
            addSubview(priorityStack)
            
            NSLayoutConstraint.activate([
                timeStack.trailingAnchor.constraint(equalTo: priorityStack.leadingAnchor, constant: -10),
                priorityStack.leadingAnchor.constraint(equalTo: timeStack.trailingAnchor, constant: 10),
                priorityStack.heightAnchor.constraint(equalTo: priorityLabel.heightAnchor),
                priorityStack.widthAnchor.constraint(equalToConstant: priorityLabel.textLabel.font.lineHeight * 2.2),
                priorityStack.topAnchor.constraint(equalTo: timeStack.topAnchor),
                priorityStack.bottomAnchor.constraint(equalTo: timeStack.bottomAnchor),
            ])
            
            if isPressed{
                line.backgroundColor = .completeProgressLine
            } else {
                line.backgroundColor = .progressLine
            }
        }
        
    }
    
    /// Required initializer that is not implemented for this class.
    ///
    /// - Parameter coder: The NSCoder used for encoding and decoding.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func doneTheTask(){
        let attributedText = NSMutableAttributedString(string: taskName!.textLabel.text!)
        attributedText.addAttribute(.strikethroughStyle, value: 2, range: NSRange(location: 0, length: taskName!.textLabel.text!.count))
        
        taskName!.textLabel.attributedText = attributedText
        taskName!.textLabel.alpha = 0.4
        progressBar?.setProgress(1)
        labelPercent.text = "\(100)%"
        line.backgroundColor = .completeProgressLine
        roundedCheckbox.manualCheckCheckbox()
    }
    
    func undoneTheTask(){
        let attributedText = NSMutableAttributedString(string: taskName!.textLabel.text!)
        attributedText.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: attributedText.length))
        
        taskName!.textLabel.attributedText = attributedText
        taskName!.textLabel.alpha = 1

        line.backgroundColor = .progressLine
    }
    
    @objc func taskIsPressed(){
        delegate?.itWasPressed()
    }
}

extension TaskContainerComponent: RoundedCheckboxDelegate{
    func buttonWasPressed(pressed: Bool) {
        if pressed{
            doneTheTask()
            layoutIfNeeded()
            delegate?.wasChecked(pressed)
            line.backgroundColor = .completeProgressLine
        } else{
            let attributedText = NSMutableAttributedString(string: taskName!.textLabel.text!)
            attributedText.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: attributedText.length))
            
            taskName!.textLabel.attributedText = attributedText
            taskName!.textLabel.alpha = 1
            progressBar?.setProgress(0)
            labelPercent.text = "\(0)%"
            line.backgroundColor = .progressLine
            
            delegate?.wasChecked(pressed)
            layoutIfNeeded()
            
        }
    }
}
