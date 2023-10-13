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
  let feedbackImpact = UIImpactFeedbackGenerator(style: .soft)
  
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
  
  var icon: ChooseIconComponent?
  
  let colorPicker: ColorChooseComponent = {
    let colorPicker = ColorChooseComponent()
    colorPicker.translatesAutoresizingMaskIntoConstraints = false
    return colorPicker
  }()
  
  // Buttons
  let buttonDone: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.title = String(localized: "Done")
    return button
  }()
  
  let buttonCancel: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.title = String(localized: "Cancel")
    button.tintColor = .red
    return button
  }()
  
  let updateButton: UIButton = {
    let button = UIButton(primaryAction: nil)
    button.setTitleColor(.white, for: .normal)
      button.backgroundColor = .primaryBlue
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
      let textField = TextDescriptionComponent(placeholderColor: .descriptionPlaceholder, textColor: .descriptionText)
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
  
  let pencil: UIButton = {
    let pencil = UIButton()
    pencil.setImage(UIImage(systemName: "pencil"), for: .normal)
    pencil.isUserInteractionEnabled = false
    pencil.contentMode = .scaleAspectFit
    pencil.tintColor = .black
    return pencil
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
      icon = ChooseIconComponent(father: self)
      icon!.iconName = "pencil.tip"
      icon!.horizontalPadding = 10
      icon!.verticalPadding = 15
      icon!.isSelectable = true
      icon!.translatesAutoresizingMaskIntoConstraints = false
    
      view.backgroundColor = UIColor(.customBackground)
    title = String(localized: "EditTaskKey")
    
    let bgColor = UIColor(red: viewModel!.task!.red, green: viewModel!.task!.green, blue: viewModel!.task!.blue, alpha: 1)
    
    colorPicker.deselectAllButtons()
    colorPicker.layoutIfNeeded()
    
    setUpDelegates()
    setUpUI()
    addActions()
    setConstraints()
    
    selectionFeedbackGenerator.prepare()
    feedbackImpact.prepare()
    
    nameTextField.textFieldToGetTheName.text = viewModel?.task?.name
    deadLine.startDatePicker.setDate(viewModel?.task?.start ?? Date.now, animated: true)
    deadLine.endDatePicker.setDate(viewModel?.task?.end ?? Date.now, animated: true)
    
    if let priority = viewModel?.task?.priority {
      segmentedControl.priority = priority
      
      if let index = segmentedControl.indexForPriority(priority) {
        segmentedControl.selectedSegmentIndex = index
      }
    }
    
    descriptionTextField.descriptionBox.text = viewModel?.task?.descript
    icon!.changeColor(bgColor: bgColor, tintColor: UIColor.selectTheBestColor(color: bgColor, isBackground: true))
    icon!.iconName = viewModel?.task?.icon
    
  }
  
  deinit{
    NotificationCenter.default.removeObserver(self)
  }
  
  func setUpDelegates(){
    colorPicker.delegate = self
    icon!.delegate = self
  }
  
  func setUpUI(){
    priorityContainer = ContainerComponent(text: String(localized: "PriorityName"), textColor: .white, acessibilityLabel: String(localized: "PriorityName"), components: [segmentedControl])
    priorityContainer?.translatesAutoresizingMaskIntoConstraints = false
    dateContainer = ContainerComponent(text: String(localized: "DeadLineKey"), acessibilityLabel: String(localized: "DeadLineKey"), components: [deadLine])
    dateContainer?.translatesAutoresizingMaskIntoConstraints = false
    descriptionContainer = ContainerComponent(text: String(localized: "DescriptionKey"), textColor: .white, acessibilityLabel: String(localized: "DescriptionKey"),button: pencil, components: [descriptionTextField])
    descriptionContainer?.translatesAutoresizingMaskIntoConstraints = false
    
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    deadLine.translatesAutoresizingMaskIntoConstraints = false
    
    navigationController?.isNavigationBarHidden = false
    
    navigationItem.rightBarButtonItem = buttonDone
    navigationItem.leftBarButtonItem = buttonCancel
    
    view.addSubview(scrollView)
    scrollView.addSubview(stackViewContainers)
    
    stackViewContainers.addArrangedSubview(stackViewForIcon)
    stackViewContainers.addArrangedSubview(dateContainer!)
    stackViewContainers.addArrangedSubview(priorityContainer!)
    stackViewContainers.addArrangedSubview(descriptionContainer!)
    stackViewContainers.addArrangedSubview(updateButton)
    
    stackViewContainers.addArrangedSubview(deleteButton)
    
    stackViewForIcon.addArrangedSubview(icon!)
    stackViewForIcon.addArrangedSubview(stackViewForTitleAndColor)
    
    stackViewForTitleAndColor.addArrangedSubview(nameTextField)
    stackViewForTitleAndColor.addArrangedSubview(colorPicker)

  }
  
  func addActions() {
    deadLine.startDatePicker.minimumDate = viewModel?.task?.start
    deadLine.startDatePicker.maximumDate = viewModel?.task?.end
    
    deadLine.endDatePicker.minimumDate = viewModel?.task?.start
    deadLine.endDatePicker.maximumDate = viewModel?.task?.end
    
    deadLine.startDatePicker.addTarget(self, action: #selector(getStartDate), for: .valueChanged)
    deadLine.endDatePicker.addTarget(self, action: #selector(getEndDate), for: .valueChanged)
    
    buttonDone.target = self
    buttonDone.action = #selector(updateTask)
    
    buttonCancel.target = self
    buttonCancel.action = #selector(cancelTask)
    
    updateButton.addTarget(self, action: #selector(updateTask), for: .touchUpInside)
    
    deleteButton.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    tapGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGesture)
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
      
      icon!.widthAnchor.constraint(equalToConstant: 93),
      icon!.heightAnchor.constraint(equalToConstant: 93),
      
      updateButton.heightAnchor.constraint(equalToConstant: 55),
      
      descriptionTextField.heightAnchor.constraint(equalToConstant: 150),
      
    ])
  }
  
}

extension TaskEditionView {
  
  @objc func dismissKeyboard(){
    view.endEditing(true)
  }
  
  @objc func cancelTask(){
    self.feedbackImpact.impactOccurred(intensity: 1)
    viewModel?.removeTopView()
  }
  
  @objc func getStartDate(_ sender: UIDatePicker){
    let selectedDate = sender.date
    viewModel!.start = selectedDate
  }
  
  @objc func getEndDate(_ sender: UIDatePicker){
    let selectedDate = sender.date
    viewModel!.end = selectedDate
  }
  
  @objc func updateTask() {
    if (viewModel?.compareDates() == .orderedAscending){
      self.viewModel?.name = nameTextField.getText() == "" ? self.viewModel?.name : nameTextField.textFieldToGetTheName.text
      self.viewModel?.description = descriptionTextField.getText() == "" ? self.viewModel?.description : descriptionTextField.getText()
      self.viewModel?.priority = segmentedControl.priority
      viewModel?.editTask()
      viewModel?.removeTopView()
    } else {
      let alert = UIAlertController(title: String(localized: "ErrorCreationTaskKey"), message: String(localized: "dateFinalBeforeBegin"), preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: String(localized: "TryAgainKey"), style: .cancel))
      self.present(alert, animated: true)
    }
    
    selectionFeedbackGenerator.selectionChanged()
  }
  
  @objc func deleteTask() {
    let alert = UIAlertController(title: String(localized: "sureKey"), message: String(localized: "actionPermanent"), preferredStyle: .alert)
    self.selectionFeedbackGenerator.selectionChanged()
    alert.addAction(UIAlertAction(title: String(localized: "yesKey"), style: .destructive, handler: { _ in
      self.feedbackImpact.impactOccurred(intensity: 1)
      self.viewModel?.deleteTask()
      self.viewModel?.removeTopView()
    }))
    
    alert.addAction(UIAlertAction(title: String(localized: "noKey"), style: .cancel))
    self.present(alert, animated: true)
  }
  
  @objc func keyboardWillShow(_ notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      
      let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
      scrollView.contentInset = contentInset
      scrollView.scrollIndicatorInsets = contentInset
    }
  }
  
  @objc func keyboardWillHide(_ notification: Notification) {
    scrollView.contentInset = .zero
    scrollView.scrollIndicatorInsets = .zero
  }
  
}

extension TaskEditionView: ColorChooseComponentDelegate, ChooseIconComponentDelegate  {
  
  func updateColor() {
    let color = colorPicker.returnColorUIColor()
    let CGColor = colorPicker.returnColorCGFloat()
    icon!.changeColor(bgColor: color, tintColor: UIColor.selectTheBestColor(color: color, isBackground: true))
    viewModel?.red = CGColor[0]
    viewModel?.green = CGColor[1]
    viewModel?.blue = CGColor[2]
  }
  
  func menuWasPressed(_ menuIcon: String) {
    
  }
  
}

extension TaskEditionView: PickIconComponentDelegate{
    func buttonWasPressed(_ menuIcon: String) {
        self.viewModel?.selectedIcon(menuIcon)
        icon!.iconName = menuIcon
    }
    
    
}
