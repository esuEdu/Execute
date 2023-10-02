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
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 10)
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
  }()

  private let deleteButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "xmark"), for: .normal)
    button.tintColor = .black
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  init(name: String) {
    super.init(frame: .zero)

    self.backgroundColor = .white
    self.layer.cornerRadius = 10
    self.addSubview(stackView)
    
    let labelSubTasks = LabelComponent(text: name, accessibilityLabel: name)
    labelSubTasks.textLabel.font = .systemFont(ofSize: 16)
       
    stackView.addArrangedSubview(checkbox)
    stackView.addArrangedSubview(labelSubTasks)
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
