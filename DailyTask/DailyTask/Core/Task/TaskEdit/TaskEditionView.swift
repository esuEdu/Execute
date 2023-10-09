//
//  TaskEditionView.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 09/10/23.
//

import Foundation
import UIKit

class TaskEditionView: UIViewController {
  
  var viewModel: TaskEditionViewModel?
  
  let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
  
  // Containers
  var priorityContainer: ContainerComponent?
  var dateContainer: ContainerComponent?
  var descriptionContainer: ContainerComponent?
  //var subTasksContainer: ContainerComponent?
  
  //Dates
  var dateStart: Date?
  var dateEnd: Date?
  
  // Pickers
  let segmentedControl = SegmentedControl()
  
  let deadLine = DeadlineComponent()
  
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
  
  // Buttons
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
  
  let updateButton: UIButton = {
    let button = UIButton(primaryAction: nil)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 10
    button.setTitle(String(localized: "UpdateTaskKey"), for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  let deleteButton: UIButton = {
    let button = UIButton(primaryAction: nil)
    button.setTitleColor(.systemRed, for: .normal)
    button.setTitle(String(localized: "DeleteTaskKey"), for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  // TextFields
  let nameTextField: TextFieldComponent = {
    let textField = TextFieldComponent()
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  let descriptionTextField: TextDescriptionComponent = {
    let textField = TextDescriptionComponent(placeholderColor: .systemGray, textColor: .black)
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.horizontalPadding = 10
    textField.verticalPadding = 10
    return textField
  }()
  
  // Main ScrollView and View
  let scrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.showsVerticalScrollIndicator = false
    return sv
  }()
  
  // Stack Views
  let stackViewContainers: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 25
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20)
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
    
    view.backgroundColor = .systemBackground
    title = String(localized: "EditTaskKey")
    
    let bgColor = UIColor(red: viewModel!.task!.red, green: viewModel!.task!.green, blue: viewModel!.task!.blue, alpha: 1)
    
    colorPicker.deselectAllButtons()
    colorPicker.layoutIfNeeded()
    
    setUpDelegates()
    setUpUI()
    setConstraints()
    
  }
  
  func setUpDelegates(){
    colorPicker.delegate = self
    icon.delegate = self
  }
  
  func setUpUI(){
    
    deadLine.startDatePicker.minimumDate = viewModel?.task?.start
    deadLine.startDatePicker.maximumDate = viewModel?.task?.end
    
    deadLine.endDatePicker.minimumDate = viewModel?.task?.start
    deadLine.endDatePicker.maximumDate = viewModel?.task?.end
    
    priorityContainer = ContainerComponent(text: String(localized: "PriorityName"), textColor: .black, components: [segmentedControl])
    priorityContainer?.translatesAutoresizingMaskIntoConstraints = false
    dateContainer = ContainerComponent(text: String(localized: "DeadLineKey"), components: [deadLine])
    dateContainer?.translatesAutoresizingMaskIntoConstraints = false
    descriptionContainer = ContainerComponent(text: String(localized: "DescriptionKey"), textColor: .black, components: [descriptionTextField])
    descriptionContainer?.translatesAutoresizingMaskIntoConstraints = false
    //    subTasksContainer = ContainerComponent(text: String(localized: "SubtasksKey"), button: buttonCreateSubtask, components: [])
    //    subTasksContainer?.stackViewContainer.spacing = 8
    
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    deadLine.translatesAutoresizingMaskIntoConstraints = false
    
    navigationController?.isNavigationBarHidden = false
    
    navigationItem.rightBarButtonItem = buttonDone
    buttonDone.target = self
    buttonDone.action = #selector(updateTask)
    navigationItem.leftBarButtonItem = buttonCancel
    buttonCancel.target = self
    buttonCancel.action = #selector(cancelTask)
    
    view.addSubview(scrollView)
    scrollView.addSubview(stackViewContainers)
    
    stackViewContainers.addArrangedSubview(stackViewForIcon)
    stackViewContainers.addArrangedSubview(dateContainer!)
    stackViewContainers.addArrangedSubview(priorityContainer!)
    //    stackViewContainers.addArrangedSubview(subTasksContainer!)
    stackViewContainers.addArrangedSubview(descriptionContainer!)
    stackViewContainers.addArrangedSubview(updateButton)
    
    updateButton.addTarget(self, action: #selector(updateTask), for: .touchUpInside)
    
    stackViewContainers.addArrangedSubview(deleteButton)
    
    stackViewForIcon.addArrangedSubview(icon)
    stackViewForIcon.addArrangedSubview(stackViewForTitleAndColor)
    
    stackViewForTitleAndColor.addArrangedSubview(nameTextField)
    stackViewForTitleAndColor.addArrangedSubview(colorPicker)
    
  }
  
  func setConstraints(){
    
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      stackViewContainers.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackViewContainers.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackViewContainers.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackViewContainers.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackViewContainers.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      
      icon.widthAnchor.constraint(equalToConstant: 93),
      icon.heightAnchor.constraint(equalToConstant: 93),
      
      descriptionTextField.heightAnchor.constraint(equalToConstant: 150),
    ])
  }
  
  @objc func cancelTask(){
      viewModel?.removeTopView()
  }
  
  @objc func updateTask(){
    
    if (viewModel?.compareDates() == .orderedAscending){
      self.viewModel?.name = nameTextField.getText() == "" ? self.viewModel?.name : nameTextField.textFieldToGetTheName.text
      self.viewModel?.description = descriptionTextField.getText() == "" ? self.viewModel?.description : descriptionTextField.getText()
      viewModel?.editTask()
      viewModel?.removeTopView()
    } else {
      let alert = UIAlertController(title: "Erro de criação", message: "Você não pode criar um projeto que termine no passado", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Tentar de novo", style: .cancel))
      self.present(alert, animated: true)
    }
    
    selectionFeedbackGenerator.selectionChanged()
    
  }
  
}

extension TaskEditionView: ColorChooseComponentDelegate, ChooseIconComponentDelegate  {
  
  func updateColor() {
    let color = colorPicker.returnColorUIColor()
    let CGColor = colorPicker.returnColorCGFloat()
    icon.changeColor(bgColor: color, tintColor: UIColor.selectTheBestColor(color: color, isBackground: true))
    viewModel?.red = CGColor[0]
    viewModel?.green = CGColor[1]
    viewModel?.blue = CGColor[2]
  }
  
  func menuWasPressed(_ menuIcon: String) {
    self.viewModel?.selectedIcon(menuIcon)
    icon.iconName = menuIcon
  }
  
}
