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
  
  let segmentedControl = SegmentedControl()
  
  var priorityContainer: ContainerComponent?
  
  var dateContainer: ContainerComponent?
  let deadLine = DeadlineComponent()
  
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

  let nameTextField: TextFieldComponent = {
      let textField = TextFieldComponent()
    textField.textFieldToGetTheName.placeholder = String(localized: "PlaceholderNameTask", comment: "Placeholder text name task")
      textField.translatesAutoresizingMaskIntoConstraints = false
      return textField
  }()
  
  var descriptionContainer: ContainerComponent?
  let descriptionTextField: TextDescriptionComponent = {
      let textField = TextDescriptionComponent(placeholderColor: .systemGray, textColor: .black)
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.horizontalPadding = 10
      textField.verticalPadding = 10
      return textField
  }()
  
  var subTasksContainer: ContainerComponent?
  let subTasksComponent = SubtasksInTasksComponent(name: "teste")
  let buttonCreateSubtask: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.tintColor = .black
    return button
  }()

  let icon: ChooseIconComponent = {
    let icon = ChooseIconComponent()
    icon.iconName = "pencil.tip"
    icon.horizontalPadding = 10
    icon.verticalPadding = 15
      icon.isSelectable = true
    icon.translatesAutoresizingMaskIntoConstraints = false
    return icon
  }()
  
  let colorPicker: ColorChooseComponent = {
    let colorPicker = ColorChooseComponent()
    colorPicker.translatesAutoresizingMaskIntoConstraints = false
    return colorPicker
  }()

  let stackViewContainers: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .vertical
      stackView.alignment = .fill
      stackView.spacing = 25
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
  }()
  
  let stackViewForTitleAndColor = {
      let stackView = UIStackView()
      stackView.axis = .vertical
    stackView.distribution = .fillEqually
      stackView.spacing = 14
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
  }()
  
  let stackViewForIcon = {
      let stackView = UIStackView()
      stackView.axis = .horizontal
    stackView.distribution = .fillProportionally
      stackView.spacing = 14
      stackView.translatesAutoresizingMaskIntoConstraints = false
      return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = String(localized: "CreateTaskTitleKey")
    view.backgroundColor = .systemBackground
    
    deadLine.startDatePicker.addTarget(self, action: #selector(getStartDate), for: .valueChanged)
    
    deadLine.endDatePicker.addTarget(self, action: #selector(getEndDate), for: .valueChanged)
    
    nameTextField.textFieldToGetTheName.returnKeyType = .done
    nameTextField.textFieldToGetTheName.autocapitalizationType = .none
    nameTextField.textFieldToGetTheName.autocorrectionType = .no
    nameTextField.textFieldToGetTheName.keyboardAppearance = .default
    nameTextField.delegate = self
      icon.delegate = self
      colorPicker.delegate = self
    
    navigationItem.rightBarButtonItem = buttonDone
    navigationItem.leftBarButtonItem = buttonCancel
    
    buttonDone.target = self
    buttonDone.action = #selector(createTask)
      
    buttonCancel.target = self
    buttonCancel.action = #selector(cancelTask)
      
      buttonCreateSubtask.addTarget(self, action: #selector(goToCreateSubtask), for: .touchUpInside)

    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    
    priorityContainer = ContainerComponent(text: String(localized: "PriorityName"), textColor: .black, components: [segmentedControl])
    priorityContainer?.translatesAutoresizingMaskIntoConstraints = false
    
    dateContainer = ContainerComponent(text: String(localized: "DeadLineKey"), components: [deadLine])
    dateContainer?.translatesAutoresizingMaskIntoConstraints = false
    
    descriptionContainer = ContainerComponent(text: String(localized: "DescriptionKey"), textColor: .black, components: [descriptionTextField])
    descriptionContainer?.translatesAutoresizingMaskIntoConstraints = false
    
    subTasksContainer = ContainerComponent(text: String(localized: "SubtasksKey"), button: buttonCreateSubtask, components: [subTasksComponent])
    subTasksContainer?.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(stackViewContainers)
    
    stackViewContainers.addArrangedSubview(stackViewForIcon)
    
    stackViewForIcon.addArrangedSubview(icon)
    stackViewForIcon.addArrangedSubview(stackViewForTitleAndColor)
    
    stackViewForTitleAndColor.addArrangedSubview(nameTextField)
    stackViewForTitleAndColor.addArrangedSubview(colorPicker)
    
    stackViewContainers.addArrangedSubview(dateContainer!)
    stackViewContainers.addArrangedSubview(priorityContainer!)
    stackViewContainers.addArrangedSubview(subTasksContainer!)
    stackViewContainers.addArrangedSubview(descriptionContainer!)

    setConstraints()
  }
  
  func setConstraints() {
  
    NSLayoutConstraint.activate([
      stackViewContainers.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      stackViewContainers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
      stackViewContainers.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
      
      icon.widthAnchor.constraint(equalToConstant: 93),
      icon.heightAnchor.constraint(equalToConstant: 93),
      
      subTasksComponent.checkbox.heightAnchor.constraint(equalToConstant: 30),
      subTasksComponent.checkbox.widthAnchor.constraint(equalToConstant: 29),
      
      descriptionTextField.heightAnchor.constraint(equalToConstant: 150),
    ])
  }
  
    
}

extension CreateTaskView: TextFieldComponentDelegate, UITextViewDelegate {
  
  func textFieldDidEndEditing() {
    
  }
  
  func textFieldDidBeginEditing() {
    
  }
 
  @objc func createTask() {
    
      let color = colorPicker.returnColorCGFloat()
      let red = color[0]
      let green = color[1]
      let blue = color[2]
      
      self.viewModel?.createTask(name: self.nameTextField.textFieldToGetTheName.text != "" ? self.nameTextField.textFieldToGetTheName.text! : "Sem nome", startDate: self.dateStart ?? Date.now, endDate: self.dateEnd ?? Date.now, priority: self.segmentedControl.priority ?? Priority.noPriority.rawValue, descript: self.descriptionTextField.getText() != "" ? self.descriptionTextField.getText() : "Sem descrição", red: red, green: green, blue: blue)
  
    viewModel?.removeLastView()
  }
  
  @objc func cancelTask(){
    viewModel?.removeLastView()
  }
  
  @objc func getStartDate(_ sender: UIDatePicker){
    let selectDate = sender.date
    self.dateStart = selectDate
  }
    
    @objc func goToCreateSubtask(){
        viewModel?.goToCreateSubtask()
    }
  
  @objc func getEndDate(_ sender: UIDatePicker){
    let selectDate = sender.date
    self.dateEnd = selectDate
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    print("inside of textViewDidBeginEditing")
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    print("inside of textViewDidEndEditing")
  }

}

extension CreateTaskView: ChooseIconComponentDelegate, ColorChooseComponentDelegate{
    func updateColor() {
        let color = colorPicker.returnColorUIColor()
        print(color)
        icon.changeColor(bgColor: selectTheBestColor(color: color, isBackground: false), tintColor: color)
    }
    
    func menuWasPressed(_ menuIcon: String) {
        icon.iconName = menuIcon
    }
}


#Preview {
  CreateTaskView()
}
