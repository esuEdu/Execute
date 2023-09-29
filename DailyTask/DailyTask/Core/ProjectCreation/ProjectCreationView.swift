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
    let methodologyButton: ChooseMethodologyComponent = ChooseMethodologyComponent(font: UIFont.preferredFont(forTextStyle: .body), text: "CBL", textColor: .black)
    
    
    var dateContainer: ContainerComponent?
    var tagsContainer: ContainerComponent?
    let addTagButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        return button
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
        #warning("NSLocalized")
        button.setTitle("Criar no projeto", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addAllConstraints()
    }
    
    func setUpUI(){
        #warning("Localized")
        dateContainer = ContainerComponent(text: "Prazo", textColor: .black, components: [])
        tagsContainer = ContainerComponent(text: "Etiquetas", textColor: .black, button: addTagButton, components: [])
        
        descriptionContainer = ContainerComponent(text: "Descrição", textColor: .black, components: [descriptionTextField])
        
        methodologyContainer = ContainerComponent(text: "Metodologia", textColor: .black, components: [methodologyButton])
        methodologyContainer?.translatesAutoresizingMaskIntoConstraints = false
        methodologyButton.delegate = self
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = createRightButtom()
        self.navigationItem.leftBarButtonItem = createLeftButtom()
        self.title = "Criar projeto"
        self.view.addSubview(iconButton)
        self.view.addSubview(textFieldToGetTheName)
        self.view.addSubview(colorChooser)
        self.view.addSubview(stackViewForTheContainer)
        
        stackViewForTheContainer.addArrangedSubview(methodologyContainer!)
        stackViewForTheContainer.addArrangedSubview(dateContainer!)
        stackViewForTheContainer.addArrangedSubview(tagsContainer!)
        stackViewForTheContainer.addArrangedSubview(descriptionContainer!)
        
        
        
        view.addSubview(createButton)
        
        iconButton.menu = setIcon()
        createButton.addTarget(self, action: #selector(defineProjectData), for: .touchUpInside)
        addTagButton.addTarget(self, action: #selector(goToTagCreation), for: .touchUpInside)
    }

    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            
            stackViewForTheContainer.topAnchor.constraint(equalTo: iconButton.bottomAnchor, constant: 25),
            stackViewForTheContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackViewForTheContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            iconButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            iconButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            iconButton.heightAnchor.constraint(equalToConstant: 93),
            iconButton.widthAnchor.constraint(equalToConstant: 93),
            
            textFieldToGetTheName.leadingAnchor.constraint(equalTo: iconButton.trailingAnchor, constant: 20),
            textFieldToGetTheName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldToGetTheName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            colorChooser.topAnchor.constraint(equalTo: textFieldToGetTheName.bottomAnchor, constant: 12),
            colorChooser.leadingAnchor.constraint(equalTo: textFieldToGetTheName.leadingAnchor),
            colorChooser.trailingAnchor.constraint(equalTo: textFieldToGetTheName.trailingAnchor),
            colorChooser.bottomAnchor.constraint(equalTo: iconButton.bottomAnchor),
            
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
            self.projectCreationViewModel?.name = textFieldToGetTheName.textFieldToGetTheName.text == "" ? self.projectCreationViewModel?.name : textFieldToGetTheName.textFieldToGetTheName.text
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
    
    @objc func goToTagCreation(){
        projectCreationViewModel?.goToTagCreation()
    }

}

#warning("REFATORAR")
extension ProjectCreationView {
    
    func createRightButtom() -> UIBarButtonItem{
        let buttonToContinue: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.title = "Concluido"
            button.target = self
            button.action = #selector(defineProjectData)
            return button
        }()

        return buttonToContinue
    }

    func createLeftButtom() -> UIBarButtonItem{
        let buttonToContinue: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.title = "Cancelar"
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

#Preview{
    ProjectCreationView()
}
