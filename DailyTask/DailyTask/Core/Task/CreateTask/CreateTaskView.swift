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
    
    // Stack Views
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
        
        configurateComponents()
        setUpUI()
        setConstraints()
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
        buttonCreateSubtask.addTarget(self, action: #selector(goToCreateSubtask), for: .touchUpInside)
        deadLine.startDatePicker.addTarget(self, action: #selector(getStartDate), for: .valueChanged)
        deadLine.endDatePicker.addTarget(self, action: #selector(getEndDate), for: .valueChanged)
    }
    
    func setUpUI(){
        navigationItem.rightBarButtonItem = buttonDone
        navigationItem.leftBarButtonItem = buttonCancel
        
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
        
    }
    
    func createNewSubtask(){
        let subTasksComponent = SubtasksInTasksComponent(name: "teste")
        subTasksContainer?.stackViewContainer.addArrangedSubview(subTasksComponent)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackViewContainers.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackViewContainers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackViewContainers.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
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
        let subtasks = subTasksContainer?.getSubtasks() ?? []
        
        self.viewModel?.createTask(name: self.nameTextField.textFieldToGetTheName.text != "" ? self.nameTextField.textFieldToGetTheName.text! : "Sem nome", startDate: self.dateStart ?? Date.now, endDate: self.dateEnd ?? Date.now, priority: self.segmentedControl.priority ?? Priority.noPriority.rawValue, descript: self.descriptionTextField.getText() != "" ? self.descriptionTextField.getText() : "Sem descrição", red: red, green: green, blue: blue, subtasks: [])
        
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
        
    }
    
    @objc func getEndDate(_ sender: UIDatePicker){
        let selectDate = sender.date
        self.dateEnd = selectDate
    }
    
}

extension CreateTaskView: ChooseIconComponentDelegate, ColorChooseComponentDelegate{
    // Pickers cofigurations with delegate
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
