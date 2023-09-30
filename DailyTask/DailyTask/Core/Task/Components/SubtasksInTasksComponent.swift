//
//  SubtasksInTasksComponent.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 29/09/23.
//

import Foundation
import UIKit

class SubtasksInTasksComponent: UIView {
  
  let checkbox = Checkbox()
  
  private let stackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .horizontal
      stackView.alignment = .center
      stackView.distribution = .fill
      stackView.spacing = 5
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
  }()
  
  private let formatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    dateFormatter.timeZone = .current
    return dateFormatter
  }()
  
  private let deleteButton: UIButton = {
    let button = UIButton()
    button.setTitle("x", for: .normal)
    return button
  }()
  
  init(name: String, date: Date) {
    super.init(frame: .zero)

    self.addSubview(stackView)
    
    let labelSubTasks = LabelComponent(text: name, accessibilityLabel: name)
    
    let dateFormatted = self.formatter.string(from: date)
    
    let labelDate = LabelComponent(text: dateFormatted, accessibilityLabel: dateFormatted)
    
    stackView.addArrangedSubview(checkbox)
    stackView.addArrangedSubview(labelSubTasks)
    stackView.addArrangedSubview(labelDate)
    stackView.addArrangedSubview(deleteButton)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
