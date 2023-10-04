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
    
    // Containers
    var priorityContainer: ContainerComponent?
    var dateContainer: ContainerComponent?
    var descriptionContainer: ContainerComponent?
    var subTasksContainer: ContainerComponent?
    
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
    
    let buttonCreateSubtask: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    // TextFields
    let nameTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.textFieldToGetTheName.placeholder = String(localized: "PlaceholderNameTask", comment: "Placeholder text name task")
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
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        configurateComponents()
        setUpUI()
        setConstraints()
    }
    
    // Configuração para retirar o observador do teclado
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    func configurateComponents(){
        // View configuration
        title = String(localized: "CreateTaskTitleKey")
        view.backgroundColor = .systemBackground
        
        // Configurate the textfield
        nameTextField.textFieldToGetTheName.returnKeyType = .done
        nameTextField.textFieldToGetTheName.autocapitalizationType = .none
        nameTextField.textFieldToGetTheName.autocorrectionType = .no
        nameTextField.textFieldToGetTheName.keyboardAppearance = .default
        
        // Delegates
        nameTextField.delegate = self
        icon.delegate = self
        colorPicker.delegate = self
        
        // Constraints activated
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        priorityContainer?.translatesAutoresizingMaskIntoConstraints = false
        dateContainer?.translatesAutoresizingMaskIntoConstraints = false
        descriptionContainer?.translatesAutoresizingMaskIntoConstraints = false
        subTasksContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        // Container configuration
        priorityContainer = ContainerComponent(text: String(localized: "PriorityName"), textColor: .black, components: [segmentedControl])
        dateContainer = ContainerComponent(text: String(localized: "DeadLineKey"), components: [deadLine])
        descriptionContainer = ContainerComponent(text: String(localized: "DescriptionKey"), textColor: .black, components: [descriptionTextField])
        subTasksContainer = ContainerComponent(text: String(localized: "SubtasksKey"), button: buttonCreateSubtask, components: [])
        subTasksContainer?.stackViewContainer.spacing = 8
        
        
        // Button setted with targets and actions
        buttonDone.target = self
        buttonDone.action = #selector(createTask)
        buttonCancel.target = self
        buttonCancel.action = #selector(cancelTask)
        deadLine.startDatePicker.addTarget(self, action: #selector(getStartDate), for: .valueChanged)
        deadLine.endDatePicker.addTarget(self, action: #selector(getEndDate), for: .valueChanged)
        buttonCreateSubtask.addTarget(self, action: #selector(createSubtask), for: .touchUpInside)
        
        
        // Configuração para retirar o observador do teclado
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func setUpUI(){
        navigationItem.rightBarButtonItem = buttonDone
        navigationItem.leftBarButtonItem = buttonCancel
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackViewContainers)
        
        stackViewContainers.addArrangedSubview(stackViewForIcon)
        stackViewContainers.addArrangedSubview(dateContainer!)
        stackViewContainers.addArrangedSubview(priorityContainer!)
        stackViewContainers.addArrangedSubview(subTasksContainer!)
        stackViewContainers.addArrangedSubview(descriptionContainer!)
        
        stackViewForIcon.addArrangedSubview(icon)
        stackViewForIcon.addArrangedSubview(stackViewForTitleAndColor)
        
        stackViewForTitleAndColor.addArrangedSubview(nameTextField)
        stackViewForTitleAndColor.addArrangedSubview(colorPicker)
        
    }
    
    func createNewSubtask(){
        let subTasksComponent = SubtasksInTasksComponent(name: "teste")
        subTasksContainer?.stackViewContainer.addArrangedSubview(subTasksComponent)
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
    
}

extension CreateTaskView: TextFieldComponentDelegate {
    func textFieldDidEndEditing() {
        
    }
    
    func textFieldDidBeginEditing() {
        
    }

    // Button actions
    @objc func createTask() {
        
        let color = colorPicker.returnColorCGFloat()
        let red = color[0]
        let green = color[1]
        let blue = color[2]
        var subtask: [String] = []
        
        for component in subTasksContainer!.stackViewContainer.arrangedSubviews {
            let compon = component as! SubtasksInTasksComponent
            subtask.append(compon.returnText())
        }
        
        self.viewModel?.createTask(name: self.nameTextField.textFieldToGetTheName.text != "" ? self.nameTextField.textFieldToGetTheName.text! : "Sem nome", startDate: self.dateStart ?? Date.now, endDate: self.dateEnd ?? Date.now, priority: self.segmentedControl.priority ?? Priority.noPriority.rawValue, descript: self.descriptionTextField.getText() != "" ? self.descriptionTextField.getText() : "Sem descrição", red: red, green: green, blue: blue, subtasks: subtask)
        
        viewModel?.removeLastView()
    }
    
    @objc func cancelTask(){
        viewModel?.removeLastView()
    }
    
    @objc func getStartDate(_ sender: UIDatePicker){
        let selectDate = sender.date
        self.dateStart = selectDate
    }
    
    @objc func createSubtask(){
        let subtask = SubtasksInTasksComponent(name: "")
        subtask.deleteButton.tag = (subTasksContainer?.getPosition())!
        subtask.deleteButton.addTarget(self, action: #selector(removeAtPosition), for: .touchUpInside)
        subTasksContainer?.addNewElements(subtask)
        print(subtask.deleteButton.tag)
    }
    
    @objc func removeAtPosition(_ button: UIButton){
        let tag = button.tag
        let subtask = subTasksContainer?.stackViewContainer.arrangedSubviews[tag]
        subTasksContainer?.stackViewContainer.removeArrangedSubview(subtask!)
        subtask?.removeFromSuperview()
        
        for (index,component) in subTasksContainer!.stackViewContainer.arrangedSubviews.enumerated() {
            let compon = component as! SubtasksInTasksComponent
            compon.deleteButton.tag = index
        }
    }
    
    @objc func getEndDate(_ sender: UIDatePicker){
        let selectDate = sender.date
        self.dateEnd = selectDate
    }
    
    // Configuração para retirar o observador do teclado (TE AMO GEPETO)
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

extension CreateTaskView: ChooseIconComponentDelegate, ColorChooseComponentDelegate{
    // Pickers cofigurations with delegate
    func updateColor() {
        let color = colorPicker.returnColorUIColor()
        print(color)
        icon.changeColor(bgColor: UIColor.selectTheBestColor(color: color, isBackground: false), tintColor: color)
    }
    
    func menuWasPressed(_ menuIcon: String) {
        icon.iconName = menuIcon
    }
}



#Preview {
    CreateTaskView()
}
