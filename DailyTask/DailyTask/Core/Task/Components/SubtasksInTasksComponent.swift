//
//  SubtasksInTasksComponent.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 29/09/23.
//

import Foundation
import UIKit

/// `SubtasksInTasksComponent` is a custom UIView subclass that represents a subtask within a task.
///
/// Example usage:
///
/// ```swift
/// let subtask = SubtasksInTasksComponent(name: "Sample Subtask")
/// ```
///
/// This component consists of a checkbox, a breakable text label, and a delete button.
class SubtasksInTasksComponent: UIView {
    
    /// The checkbox associated with the subtask.
    let checkbox = Checkbox()
    
    /// The main stack view that contains all elements.
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 10)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// The breakable text label for displaying the subtask name.
    let labelSubTasks: BreakableTextComponent = {
        let label = BreakableTextComponent(placeholderColor: .systemGray2, textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// The delete button to remove the subtask.
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    /// Initializes a new `SubtasksInTasksComponent` with the given name.
    ///
    /// - Parameter name: The name of the subtask.
    init(name: String) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.addSubview(stackView)
                
        // Add checkbox, label, and delete button to the stack view
        stackView.addArrangedSubview(checkbox)
        stackView.addArrangedSubview(labelSubTasks)
        stackView.addArrangedSubview(deleteButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Set checkbox size
            checkbox.heightAnchor.constraint(equalToConstant: 30),
            checkbox.widthAnchor.constraint(equalToConstant: 29),
        ])
      
    }
    
    /// Returns the text of the subtask label.
    ///
    /// - Returns: The text of the subtask label.
    func returnText() -> String {
        return labelSubTasks.getText()
    }
    
    /// Required initializer that is not implemented for this class.
    ///
    /// - Parameter coder: The NSCoder used for encoding and decoding.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview{
    SubtasksInTasksComponent(name: "Bom dia")
}
