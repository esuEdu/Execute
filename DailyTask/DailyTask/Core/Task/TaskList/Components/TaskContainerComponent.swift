//
//  TaskContainerComponent.swift
//  DailyTask
//
//  Created by Eduardo on 02/10/23.
//

import UIKit

protocol TaskContainerComponentDelegate: AnyObject{
    func valueChanged() -> CGFloat
    func isChecked(_ check: Bool)
    func itWasPressed()
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
    
    /// The stack view for the task name label.
    let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray4
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
        line.backgroundColor = .systemBlue
        return line
    }()
    
    let bgLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .systemGray4
        return line
    }()
    
    var isUnique: Bool = true {
        didSet{
            if isUnique{
                print("ue")
                bgLine.isHidden = true
                line.isHidden = true
            } else{
                bgLine.isHidden = false
                line.isHidden = false
            }
        }
    }
    
    var taskName: LabelComponent?
    
    var touch: UITapGestureRecognizer?
    
    /// Initializes a new `TaskContainerComponent`.
    ///
    /// - Parameters:
    ///   - timeLabel: The time label to display.
    ///   - taskName: The task name to display.
    init(timeLabel: String = "18:20", taskName: String = "Sample task ljnsjdnjs n dfmd fm ndjnfjdn fjndjfndjn jkndjnfj dkn fjkdnkj nfdjknf jd", mainColor: UIColor = .systemBlue) {
        super.init(frame: .zero)
        
        touch = UITapGestureRecognizer(target: self, action: #selector(taskIsPressed))
        
        containerStack.addGestureRecognizer(touch!)
        
        if isUnique{
            bgLine.isHidden = true
            line.isHidden = true
        }
        
        containerStack.backgroundColor = mainColor.withAlphaComponent(0.5)
        timeStack.backgroundColor = mainColor
        
        labelPercent.textColor = UIColor.selectTheBestColor(color: mainColor, isBackground: true)
        
        progressBar = CircularProgressView(lineWidth: labelPercent.font.lineHeight/3.5, color: mainColor)
        progressBar!.setProgress(0)
        progressBar!.translatesAutoresizingMaskIntoConstraints = false
        
        roundedCheckbox.delegate = self
        
        // Create and configure time label
        let timeLabel = LabelComponent(text: timeLabel, accessibilityLabel: timeLabel, font: .caption1)
        
        // Create and configure task name label
        self.taskName = LabelComponent(text: taskName, accessibilityLabel: taskName, font: .footnote, numberOfLines: 2, lineBreakMode: .byTruncatingTail)
        
        #warning("Trocar")
        self.taskName?.textLabel.textColor = .black
        timeLabel.textLabel.textColor = UIColor.selectTheBestColor(color: mainColor, isBackground: true)
        
        // Add time label to the time stack
        timeStack.addArrangedSubview(timeLabel)
        
        containerStack.addArrangedSubview(self.taskName!)
        addSubview(containerStack)
        addSubview(roundedCheckbox)
        
        // Add time stack and main stack to the view
        addSubview(timeStack)
        
        addSubview(progressBar!)
        addSubview(bgLine)
        addSubview(line)
        addSubview(labelPercent)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            timeStack.topAnchor.constraint(equalTo: topAnchor),
            timeStack.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor),
            timeStack.heightAnchor.constraint(equalTo: timeLabel.heightAnchor, constant: 5),
            
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
            
            bgLine.topAnchor.constraint(equalTo: containerStack.bottomAnchor),
            bgLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgLine.heightAnchor.constraint(equalToConstant: (self.taskName!.textLabel.font.lineHeight * 3.3)/2),
            bgLine.widthAnchor.constraint(equalToConstant: (self.taskName!.textLabel.font.lineHeight * 3.3)/8.6),
            bgLine.centerXAnchor.constraint(equalTo: progressBar!.centerXAnchor),
            
        ])
        
//        let lineWidth = (self.taskName!.textLabel.font.lineHeight * 3.3 ) / 8.6
//        
//        line.layer.cornerRadius = (lineWidth / 2.5)
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
        if !isUnique{
            line.isHidden = false
        }
    }
    
    @objc func taskIsPressed(){
        delegate?.itWasPressed()
        print("Cheguei")
    }
}

extension TaskContainerComponent: RoundedCheckboxDelegate{
    func buttonWasPressed(pressed: Bool) {
        if pressed{
            doneTheTask()
            layoutIfNeeded()
        } else{
            let attributedText = NSMutableAttributedString(string: taskName!.textLabel.text!)
            attributedText.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: attributedText.length))
            
            taskName!.textLabel.attributedText = attributedText
            taskName!.textLabel.alpha = 1
            progressBar?.setProgress(0)
            labelPercent.text = "\(0)%"
            if !isUnique{
                line.isHidden = true
            }
            layoutIfNeeded()
        }
    }
}

#Preview{
    TaskContainerComponent()
}
