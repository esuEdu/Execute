//
//  CreateTaskView.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 24/09/23.
//

import Foundation
import UIKit

class CreateTaskView: UIViewController {
  var viewModel: TaskViewModel?
  
  let nameTextField: UITextField = {
      let textField = UITextField()
      textField.placeholder = "Type the name of the task"
      textField.translatesAutoresizingMaskIntoConstraints = false
      return textField
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Create Task"
    view.backgroundColor = .systemGray
    
    nameTextField.returnKeyType = .done
    nameTextField.autocapitalizationType = .words
    nameTextField.autocorrectionType = .no
    nameTextField.delegate = self
    
    view.addSubview(nameTextField)
  
    setConstraints()
  }
  
  func setConstraints() {
  
    NSLayoutConstraint.activate([
    
      nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
      nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

    ])
  }
  
}

extension CreateTaskView: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if let text = textField.text {
      viewModel?.createTask(name: text, startDate: Date.now, endDate: Date.now, priority: "alta", descript: "testando o crud ao criar uma tarefa")
    }
    return true
  }
  
}

#Preview {
  CreateTaskView()
}
