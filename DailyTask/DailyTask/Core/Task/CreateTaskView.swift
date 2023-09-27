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
  
  var dateStart: Date?
  var dateEnd: Date?
  
  var dateIsChanged: Bool?
  
  let segmentedControl = SegmentedControl(items: ["indefinido", "5 min", "15 min", "30 min", "1h"])
  
  let nameTextField: UITextField = {
      let textField = UITextField()
      textField.placeholder = String(localized: "PlaceholderNameTask", comment: "Placeholder text name task")
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
  
  let endDate: DatePickerView<Date> = {
    let date = DatePickerView<Date>()
    date.datePickerMode = .dateAndTime
    date.translatesAutoresizingMaskIntoConstraints = false
    return date
  }()
  
  let buttonDone: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.title = String(localized: "CreateTaskButton", comment: "Button in the navigation bar that create the task")
    return button
  }()
  
  let buttonCancel: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.title = String(localized: "CancelTaskButton", comment: "Button in the navigation bar that cancel the task creation")
    button.tintColor = .red
    return button
  }()
  
  let labelDateStart: UILabel = {
    let label = UILabel()
    label.text = String(localized: "StartDateLabel", comment: "text of start date of the task creation")
    label.numberOfLines = 1
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let labelDateEnd: UILabel = {
    let label = UILabel()
    label.text = String(localized: "EndDateLabel", comment: "text of end date")
    label.numberOfLines = 1
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Create Task"
    view.backgroundColor = .systemBackground
    
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
    desc.backgroundColor = .systemGray3
    desc.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
    desc.delegate = self
    
//    let gesture = UIGestureRecognizer(target: self, action: #selector(tappedAwayFunction))
//    self.view.addGestureRecognizer(gesture)
    
    navigationItem.rightBarButtonItem = buttonDone
    navigationItem.leftBarButtonItem = buttonCancel
    
    buttonDone.target = self
    buttonDone.action = #selector(createTask)
    
    buttonCancel.target = self
    buttonCancel.action = #selector(cancelTask)
    
    startDate.valueChangedHandler = { selectedDate in
      self.dateStart = selectedDate
    }
    
    endDate.valueChangedHandler = { selectedDate in
      self.segmentedControl.dateIsSelected = false
      self.dateIsChanged = true
      self.dateEnd = selectedDate
    }
  
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(segmentedControl)
    
    view.addSubview(nameTextField)
    view.addSubview(desc)
    view.addSubview(startDate)
    view.addSubview(endDate)
    view.addSubview(labelDateStart)
    view.addSubview(labelDateEnd)

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
      startDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      
      endDate.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: 20),
      endDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      
      labelDateStart.topAnchor.constraint(equalTo: startDate.topAnchor),
      labelDateStart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      labelDateStart.bottomAnchor.constraint(equalTo: startDate.bottomAnchor),
      
      labelDateEnd.topAnchor.constraint(equalTo: endDate.topAnchor),
      labelDateEnd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      labelDateEnd.bottomAnchor.constraint(equalTo: endDate.bottomAnchor),
      
      segmentedControl.topAnchor.constraint(equalTo: endDate.bottomAnchor, constant: 20),
      segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      
    ])
  }
  
}

extension CreateTaskView: UITextFieldDelegate, UITextViewDelegate {

//  @objc func tappedAwayFunction(){
//    desc.resignFirstResponder()
//  }
  
  @objc func createTask() {
    
    if dateIsChanged == true && segmentedControl.dateIsSelected == false {
      self.viewModel?.createTask(name: self.nameTextField.text != "" ? self.nameTextField.text! : "Sem nome", startDate: self.dateStart ?? Date.now, endDate: self.dateEnd ?? Date.now, priority: Priority.low.rawValue, descript: self.desc.text != "" ? self.desc.text! : "Sem descrição")
    } else {
      
      let date = self.dateStart?.addingTimeInterval(segmentedControl.dates[0])
      
      endDate.selectedValue = date
      
      self.viewModel?.createTask(name: self.nameTextField.text != "" ? self.nameTextField.text! : "Sem nome", startDate: self.dateStart ?? Date.now, endDate: endDate.selectedValue ?? Date.now, priority: Priority.low.rawValue, descript: self.desc.text != "" ? self.desc.text! : "Sem descrição")
      
//      print(date)
      
    }

    viewModel?.removeLastView()
  }
  
  @objc func cancelTask(){
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


#Preview {
  CreateTaskView()
}
