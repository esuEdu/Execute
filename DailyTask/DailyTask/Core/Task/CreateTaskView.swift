//
//  CreateTaskView.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 24/09/23.
//

import Foundation
import UIKit

class CreateTaskView: UIViewController {
  var viewModel: CreateTaskViewModel?
  
  let nameTextField: UITextField = {
      let textField = UITextField()
      textField.placeholder = "Type the name of the task"
      textField.translatesAutoresizingMaskIntoConstraints = false
      return textField
  }()
  
  let desc: UITextView = {
      let description = UITextView()
    description.layer.cornerRadius = 10
    description.translatesAutoresizingMaskIntoConstraints = false
      return description
  }()
 
  let startDate: DatePickerView<Date> = {
    let date = DatePickerView<Date>()
    date.datePickerMode = .dateAndTime
    date.translatesAutoresizingMaskIntoConstraints = false
    return date
  }()
  
  let buttonDone: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.title = "Concluido" // Localizable
    return button
  }()
  
  let buttonCancel: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.title = "Cancelar" // Localizable
    button.tintColor = .red
    return button
  }()
  
  var data: Date?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Create Task"
    view.backgroundColor = .systemGray
    
    nameTextField.returnKeyType = .done
    nameTextField.autocapitalizationType = .none
    nameTextField.autocorrectionType = .no
    nameTextField.keyboardAppearance = .default
    nameTextField.becomeFirstResponder()
    nameTextField.delegate = self
    
//    desc.returnKeyType = .done
//    desc.autocapitalizationType = .none
//    desc.autocorrectionType = .no
//    desc.keyboardAppearance = .default
    
    desc.isEditable = true
    desc.backgroundColor = .white
    desc.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
    desc.delegate = self
    
//    let gesture = UIGestureRecognizer(target: self, action: #selector(tappedAwayFunction))
//    self.view.addGestureRecognizer(gesture)
    
    buttonDone.target = self
    buttonDone.action = #selector(createTask)
    
    navigationItem.rightBarButtonItem = buttonDone
    navigationItem.leftBarButtonItem = buttonCancel
    
    startDate.valueChangedHandler = { selectedDate in
      let dateFormatter = DateFormatter()
      dateFormatter.locale = .current
      dateFormatter.dateStyle = .long
      dateFormatter.timeStyle = .short
      let data = dateFormatter.string(from: selectedDate)
      print(data)
      self.data = selectedDate
    }
    
    view.addSubview(nameTextField)
    view.addSubview(desc)
    view.addSubview(startDate)

    setConstraints()
  }
  
  func setConstraints() {
  
    NSLayoutConstraint.activate([
    
      nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
      nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      
     desc.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
     desc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
     desc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      desc.heightAnchor.constraint(equalTo: nameTextField.heightAnchor, multiplier: 10),
      
      startDate.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 30),
      startDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
      
    ])
  }
  
}

extension CreateTaskView: UITextFieldDelegate, UITextViewDelegate {
  

//  @objc func tappedAwayFunction(){
//    desc.resignFirstResponder()
//  }
  
  @objc func createTask() {
    self.viewModel?.createTask(name: self.nameTextField.text != "" ? self.nameTextField.text! : "Sem nome", startDate: self.data ?? Date.now, endDate: Date.now, priority: Priority.low.rawValue, descript: self.desc.text != "" ? self.desc.text! : "Sem descrição")
    
    viewModel?.removeLastView()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    return true
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    print("inside of textViewDidBeginEditing")
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    print("inside of textViewDidEndEditing")
  }

}
