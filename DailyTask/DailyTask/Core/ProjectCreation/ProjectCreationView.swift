//
//  ProjectCreationViewController.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import UIKit

class ProjectCreationView: UIViewController {
    
    var projectCreationViewModel: ProjectCreationViewModel?

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite o nome do projeto aqui"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    #warning("Temporary")
    let iconTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite o icone aqui"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite a descrição aqui"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let startDatePicker: DatePickerView <Date> = {
        let datePicker = DatePickerView <Date>()
        datePicker.datePickerMode = .dateAndTime
        
        return datePicker
    }()
    
    let endDatePicker: DatePickerView = {
        let datePicker = DatePickerView <Date>()
        datePicker.datePickerMode = .dateAndTime
        
        return datePicker
    }()
    
    #warning("Temporary")
    let methodologyButton: UIButton = {
        let methodologyButton = UIButton()
        methodologyButton.setTitleColor(.white, for: .normal)
        methodologyButton.backgroundColor = .systemCyan
        methodologyButton.layer.cornerRadius = 10
        methodologyButton.setTitle("Escolha sua metodologia", for: .normal)
        return methodologyButton
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Criar", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        addAllConstraints()
    }
    
    func setMethodologyButton() -> UIMenu{
        let menuItems = UIMenu(title: "", options: .displayAsPalette, children: [
        
        UIAction(title: "CBL", image: UIImage(systemName: "globe.americas.fill"), handler: { _ in
            self.projectCreationViewModel?.methodology = .CBL
            self.methodologyButton.setTitle("Methodology \(String(describing: self.projectCreationViewModel!.methodology!.rawValue))", for: .normal)
        }),
        
        UIAction(title: "Scrum", image: UIImage(systemName: "paperplane.fill"), handler: { _ in
            self.projectCreationViewModel?.methodology = .Scrum
            self.methodologyButton.setTitle("Methodology \(String(describing: self.projectCreationViewModel!.methodology!.rawValue))", for: .normal)
        }),
        
        UIAction(title: "Custom", image: UIImage(systemName: "pencil.tip.crop.circle.badge.plus") , handler: { _ in
            self.projectCreationViewModel?.methodology = .Custom
            self.methodologyButton.setTitle("Methodology \(String(describing: self.projectCreationViewModel!.methodology!.rawValue))", for: .normal)
        }),
        
        
        ])
        
        return menuItems
    }
    
    func setUpUI(){
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItems = createGenericButtons()
        self.title = "Criar projeto"
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(iconTextField)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(descriptionTextField)
        stackView.addArrangedSubview(startDatePicker)
        stackView.addArrangedSubview(endDatePicker)
        stackView.addArrangedSubview(methodologyButton)
        stackView.addArrangedSubview(createButton)
        methodologyButton.menu = setMethodologyButton()
        createButton.addTarget(self, action: #selector(defineProjectData), for: .touchUpInside)
        
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    #warning("REFATORAR")
    @objc func defineProjectData(){
        startDatePicker.valueChangedHandler = { selectedDate in
            self.projectCreationViewModel?.start = selectedDate
            print("Cheguei w")
        }
        
        endDatePicker.valueChangedHandler = { selectedDate in
            self.projectCreationViewModel?.end = selectedDate
            print("Cheguei p")
        }
        
//        if (self.projectCreationViewModel?.start < self.projectCreationViewModel?.end){
//
//        }
        
        self.projectCreationViewModel?.icon = iconTextField.text == "" ? self.projectCreationViewModel?.icon : iconTextField.text
        self.projectCreationViewModel?.name = nameTextField.text == "" ? self.projectCreationViewModel?.name : nameTextField.text
        self.projectCreationViewModel?.description = descriptionTextField.text == "" ? self.projectCreationViewModel?.description : descriptionTextField.text
        
        self.projectCreationViewModel?.createAProject()
        self.projectCreationViewModel?.removeTopView()
    }

}

extension ProjectCreationView {
#warning("temporary")
    func createGenericButtons() -> [UIBarButtonItem]{
        let buttonToSupport: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.image = UIImage(systemName: "questionmark.circle")
            return button
        }()

        #warning("temporary")
        let buttonToConfiguration: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.image = UIImage(systemName: "gear")
            return button
        }()
        
        return [buttonToConfiguration, buttonToSupport]
    }

}

