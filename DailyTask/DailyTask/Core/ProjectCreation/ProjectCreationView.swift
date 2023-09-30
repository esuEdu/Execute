//
//  ProjectCreationViewController.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import UIKit

class ProjectCreationView: UIViewController {
    
    var projectCreationViewModel: ProjectCreationViewModel?

    // MARK: - OFICIAL
    
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
    
    let iconButton: ChooseIconComponent = {
        let iconPicker = ChooseIconComponent()
        iconPicker.horizontalPadding = 10
        iconPicker.verticalPadding = 15
        iconPicker.iconName = "pencil.tip"
        iconPicker.translatesAutoresizingMaskIntoConstraints = false
        return iconPicker
    }()
    
    let textFieldToGetTheName: TextFieldToName = {
        let textField = TextFieldToName()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let colorChooser = ColorChooseComponent()
    
    let stackViewForTheContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var methodologyContainer: ContainerComponent?
    let methodologyButton: ChooseMethodologyComponent = ChooseMethodologyComponent(font: UIFont.preferredFont(forTextStyle: .body), text: "Challenge Based Learning (CBL)", textColor: .black)
    
    
    var dateContainer: ContainerComponent?
    let deadLine: DeadlineComponent = {
        let deadLine = DeadlineComponent()
        return deadLine
    }()
    
    
    var descriptionContainer: ContainerComponent?
    let descriptionTextField: TextDescriptionComponent = {
        let textField = TextDescriptionComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.horizontalPadding = 10
        textField.verticalPadding = 10
        return textField
    }()

    let createButton: UIButton = {
        let button = UIButton(primaryAction: nil)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle(String(localized: "Create a new project"), for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addAllConstraints()
        deadLine.startDatePicker.addTarget(self, action: #selector(getStartDate), for: .valueChanged)
        deadLine.endDatePicker.addTarget(self, action: #selector(getEndDate), for: .valueChanged)
    }
    
    func setUpUI(){
        dateContainer = ContainerComponent(text: String(localized: "Deadline"), textColor: .black, components: [deadLine])
        
        descriptionContainer = ContainerComponent(text: String(localized: "Description"), textColor: .black, components: [descriptionTextField])
        
        methodologyContainer = ContainerComponent(text: String(localized: "Methodology"), textColor: .black, components: [methodologyButton])
        methodologyContainer?.translatesAutoresizingMaskIntoConstraints = false
        methodologyButton.delegate = self
        colorChooser.delegate = self
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = createRightButtom()
        self.navigationItem.leftBarButtonItem = createLeftButtom()
        self.title = String(localized: "Create a project")
        self.view.addSubview(stackViewForTheContainer)

        
        stackViewForTheContainer.addArrangedSubview(stackViewForIcon)
        stackViewForTheContainer.addArrangedSubview(methodologyContainer!)
        stackViewForTheContainer.addArrangedSubview(dateContainer!)
        stackViewForTheContainer.addArrangedSubview(descriptionContainer!)
        
        stackViewForIcon.addArrangedSubview(iconButton)
        
        stackViewForIcon.addArrangedSubview(stackViewForTitleAndColor)
        
        stackViewForTitleAndColor.addArrangedSubview(textFieldToGetTheName)
        stackViewForTitleAndColor.addArrangedSubview(colorChooser)
        
        view.addSubview(createButton)
        
        iconButton.menu = setIcon()
        createButton.addTarget(self, action: #selector(defineProjectData), for: .touchUpInside)
    }

    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            
            stackViewForTheContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            stackViewForTheContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackViewForTheContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            iconButton.widthAnchor.constraint(equalToConstant: 93),
            iconButton.heightAnchor.constraint(equalToConstant: 93),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            createButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            
            descriptionTextField.heightAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    
    #warning("REFATORAR")
    @objc func defineProjectData(){
        projectCreationViewModel?.colors = colorChooser.returnColorCGFloat()
        
        if (projectCreationViewModel?.compareDates() == .orderedAscending){
            self.projectCreationViewModel?.name = textFieldToGetTheName.getText() == "" ? self.projectCreationViewModel?.name : textFieldToGetTheName.textFieldToGetTheName.text
            self.projectCreationViewModel?.description = descriptionTextField.getText() == "" ? self.projectCreationViewModel?.description : descriptionTextField.getText()
            
            self.projectCreationViewModel?.createAProject()
            self.projectCreationViewModel?.removeTopView()
        } else{
            print("")
            #warning("Temporary")
            let alert = UIAlertController(title: "Erro de criação", message: "Você não pode criar um projeto que termine no passado, a máquina do tempo não foi inventada ainda", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tentar de novo", style: .destructive))
            self.present(alert, animated: true)
        }
        
    }
    
    @objc func removeTheView(){
        projectCreationViewModel?.removeTopView()
    }
    
    @objc func getStartDate(_ sender: UIDatePicker){
        let selectedDate = sender.date
        print("\(selectedDate)")
        projectCreationViewModel?.start = selectedDate
    }
    
    @objc func getEndDate(_ sender: UIDatePicker){
        let selectedDate = sender.date
        print("\(selectedDate)")
        projectCreationViewModel?.end = selectedDate
    }

}

#warning("REFATORAR")
extension ProjectCreationView {
    
    func createRightButtom() -> UIBarButtonItem{
        let buttonToContinue: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.title = String(localized: "Done")
            button.target = self
            button.action = #selector(defineProjectData)
            return button
        }()

        return buttonToContinue
    }

    func createLeftButtom() -> UIBarButtonItem{
        let buttonToContinue: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.title = String(localized: "Cancel")
            button.tintColor = .systemRed
            button.target = self
            button.action = #selector(removeTheView)
            return button
        }()

        return buttonToContinue
    }

    func setIcon() -> UIMenu{
        let menuItems = UIMenu(title: "", options: .displayAsPalette, children: [
            
            UIAction(title: "Globo", image: UIImage(systemName: "globe.americas.fill"), handler: { _ in
                self.iconButton.iconName = "globe.americas.fill"
                self.projectCreationViewModel?.icon = self.iconButton.iconName
            }),
            
            UIAction(title: "PaperPlane", image: UIImage(systemName: "paperplane.fill"), handler: { _ in
                self.iconButton.iconName = "paperplane.fill"
                self.projectCreationViewModel?.icon = self.iconButton.iconName
            }),
            
            UIAction(title: "Pencil", image: UIImage(systemName: "pencil.tip.crop.circle.badge.plus") , handler: { _ in
                self.iconButton.iconName = "pencil.tip.crop.circle.badge.plus"
                self.projectCreationViewModel?.icon = self.iconButton.iconName
            }),
            
            
        ])
        
        return menuItems
    }

}

extension ProjectCreationView: ChooseMethodologyComponentDelegate {
    
    func setUpMenuFunction(type: Methodologies) {
        self.projectCreationViewModel?.methodology = type
        self.methodologyButton.methodology.text = "\(String(describing: self.projectCreationViewModel!.methodology!.rawValue))"
        self.methodologyButton.layoutIfNeeded()
    }
}

extension ProjectCreationView: ColorChooseComponentDelegate {
    func updateColor() {
        iconButton.changeColor(bgColor: colorChooser.returnColorUIColor())
    }

}

#Preview{
    ProjectCreationView()
}
