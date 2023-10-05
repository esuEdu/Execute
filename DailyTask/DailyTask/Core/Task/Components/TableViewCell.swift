//
//  TableViewCell.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 03/10/23.
//

import UIKit

/// The `SubstaskInTaskTableViewCell` class represents a custom table view cell used to display subtasks within a task.
///
/// It includes a checkbox, a text component that can display and edit the subtask's text, and a delete button.
class SubstaskInTaskTableViewCell: UITableViewCell {
    
    /// A static identifier for the cell that can be used to dequeue reusable cells.
    static let identifier = "SubtaskCell"
    
    /// The main container view that holds the cell's content.
    private let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    /// The stack view that arranges the checkbox, text component, and delete button horizontally.
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 10)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// The checkbox component to indicate completion status.
    let checkbox = Checkbox()
    
    /// The text component that displays and allows editing of the subtask's text.
    let labelSubTasks: BreakableTextComponent = {
        let label = BreakableTextComponent(placeholderColor: .systemGray2, textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// The delete button to remove the subtask.
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(view)
        self.view.addSubview(stackView)
                
        stackView.addArrangedSubview(checkbox)
        stackView.addArrangedSubview(labelSubTasks)
        stackView.addArrangedSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            checkbox.heightAnchor.constraint(equalToConstant: 30),
            checkbox.widthAnchor.constraint(equalToConstant: 29),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Returns the text of the subtask.
    ///
    /// - Returns: The text of the subtask.
    func returnText() -> String{
        return labelSubTasks.getText()
    }
}

#Preview{
    SubstaskInTaskTableViewCell()
}
