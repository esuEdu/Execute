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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        addAllConstraints()
    }
    
    func setUpUI(){
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItems = createGenericButtons()
        self.title = "Criar projeto"
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(iconTextField)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(descriptionTextField)
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
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

