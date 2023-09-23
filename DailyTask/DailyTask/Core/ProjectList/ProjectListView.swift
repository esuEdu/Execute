//
//  ProjectListView.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import UIKit

class ProjectListView: UIViewController {

    var projectListViewModel: ProjectListViewModel?
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "ProjectList"
        buttonToCreateANewProject.target = self
        buttonToCreateANewProject.action = #selector(createNewProject)
        self.navigationItem.leftBarButtonItem = buttonToCreateANewProject
    }
    
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
        tableView.reloadData()
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
    
    
}

#Preview {
    ProjectListView()
}
