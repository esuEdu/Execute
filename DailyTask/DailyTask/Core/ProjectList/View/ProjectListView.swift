//
//  ProjectListView.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import UIKit

class ProjectListView: UIViewController {

    var projectListViewModel: ProjectListViewModel?
    
    // MARK: - Creating UIElements
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let buttonToCreateANewProject: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "+"
        return button
    }()
    
    // MARK: - Setting up the UIElements and constraint
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addAllConstraints()
    }
    
    // MARK: - Creating the UIElements setups
    func setUpUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.title = "Meus Projetos"
        buttonToCreateANewProject.target = self
        buttonToCreateANewProject.action = #selector(createNewProject)
        self.navigationItem.leftBarButtonItem = buttonToCreateANewProject
    }
    
    // MARK: - Adding constraint
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func createNewProject(){
        projectListViewModel?.createAProject()
        self.tableView.reloadData()
    }

}

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

