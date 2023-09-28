//
//  CheckboxViewCell.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 27/09/23.
//

import Foundation
import UIKit

class CheckboxTableViewCell: UITableViewCell {
  
  var checkbox: Checkbox = Checkbox()

  var label: UILabel = {
    let label = UILabel()
    label.text = "Vazio"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupConstraint() {
    
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
  
  func set(title: String, checked: Bool){
    label.text = title
    checkbox.checked = checked
    updateCheckbox()
  }
  
  private func updateCheckbox() {
    let attributedString = NSMutableAttributedString(string: label.text!)
    
    if checkbox.checked {
      attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
    } else {
      attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
    }
    
    label.attributedText = attributedString
    
  }
  
}

#Preview {
  CheckboxTableViewCell()
}
