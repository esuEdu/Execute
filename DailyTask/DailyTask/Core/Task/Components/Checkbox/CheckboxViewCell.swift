//
//  CheckboxViewCell.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 27/09/23.
//

import Foundation
import UIKit

import UIKit

/// A custom table view cell with a checkbox and a label.
///
/// `CheckboxTableViewCell` is a subclass of `UITableViewCell` designed for displaying
/// a checkbox and a label within a table view. It allows users to toggle the checkbox
/// to mark an item as checked or unchecked.
///
/// ## Usage
///
/// To use `CheckboxTableViewCell`, create an instance, set the title and initial
/// checkbox state using the `set(title: String, checked: Bool)` method, and then add
/// the cell to your table view. The cell will automatically handle the appearance of
/// the label based on the checkbox state.
///
/// ```swift
/// let cell = CheckboxTableViewCell(style: .default, reuseIdentifier: "CheckboxCell")
/// cell.set(title: "Sample Item", checked: false)
/// ```
///
/// - Note: `CheckboxTableViewCell` provides a user-friendly way to create checklist items
///         within a table view.
///
/// - Important: Use the `set(title: String, checked: Bool)` method to update the cell's
///              content and checkbox state.
class CheckboxTableViewCell: UITableViewCell {
    
    /// The checkbox control embedded within the cell.
    var checkbox: Checkbox = Checkbox()
    
    /// The label displaying the cell's title.
    var label: UILabel = {
        let label = UILabel()
        label.text = "Vazio"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets up the layout constraints for the cell's components.
    private func setupConstraints() {
        self.contentView.addSubview(label)
        self.contentView.addSubview(checkbox)
        
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            checkbox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            checkbox.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            checkbox.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    /// Sets the title and checkbox state for the cell.
    ///
    /// - Parameters:
    ///   - title: The text to be displayed in the cell's label.
    ///   - checked: A boolean value indicating whether the checkbox should be checked.
    func set(title: String, checked: Bool) {
        label.text = title
        checkbox.checked = checked
        updateCheckboxAppearance()
    }
    
    /// Updates the appearance of the label based on the checkbox state.
    private func updateCheckboxAppearance() {
        let attributedString = NSMutableAttributedString(string: label.text!)
        
        if checkbox.checked {
            attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributedString.length))
        } else {
            attributedString.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: attributedString.length - 1))
        }
        
        label.attributedText = attributedString
    }
}
