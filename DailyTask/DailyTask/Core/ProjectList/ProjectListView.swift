//
//  ProjectListView.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import UIKit

class ProjectListView: UIViewController {

    var projectListViewModel: ProjectListViewModel?
    
    // MARK: - Creating and setting the UIElements
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let buttonToCreateANewProject: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 13
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    #warning("temporary")
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
    
    // Setting up the UIElements and constraint
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addAllConstraints()
    }
    
    // Creating the UIElements setups
    func setUpUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(buttonToCreateANewProject)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        #warning("temporary")
        self.navigationItem.rightBarButtonItems = [buttonToConfiguration, buttonToSupport]
        title = "Meus projetos"
        
        
        buttonToCreateANewProject.addTarget(self, action: #selector(createNewProject), for: .touchUpInside)
    }
    
    // Adding constraint
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: buttonToCreateANewProject.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            buttonToCreateANewProject.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            buttonToCreateANewProject.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            buttonToCreateANewProject.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            buttonToCreateANewProject.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            

        ])
    }
    
    // MARK: - Button functions
    @objc func createNewProject(){
        projectListViewModel?.coordinator?.eventOccurred(with: .goToProjectCreation)
        
//        projectListViewModel?.createAProject()
//        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        projectListViewModel?.fetchProjectViewModel()
    }
    
    

}


// MARK: - Extension para a tableView
extension ProjectListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectListViewModel?.project?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var configure = UIListContentConfiguration.cell()
        configure.text = projectListViewModel?.project?[indexPath.row].name
        configure.secondaryText = projectListViewModel?.project?[indexPath.row].descript
        
        cell.contentConfiguration = configure
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Deletar") {(action , view , completionHandler) in
            
            let projectToDelete = self.projectListViewModel?.project![indexPath.row]
            self.projectListViewModel?.deleteAProject(project: projectToDelete!)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

