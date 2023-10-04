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
  
  var filteredData: [String] = []
  
  let searchBar: UISearchBar = {
    let search = UISearchBar()
    search.placeholder = "teste"
    search.translatesAutoresizingMaskIntoConstraints = false
    return search
  }()
  
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
      
      if let projectListViewModel = projectListViewModel, let project = projectListViewModel.project {
          for name in project {
              if let projectName = name.name {
                  filteredData.append(projectName)
              }
          }
      }
      
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(buttonToCreateANewProject)
      view.addSubview(searchBar)
    
      searchBar.delegate = self
      
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
          
          buttonToCreateANewProject.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          //buttonToCreateANewProject.bottomAnchor.constraint(equalTo: view.topAnchor),
          buttonToCreateANewProject.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
          buttonToCreateANewProject.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
          
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          searchBar.topAnchor.constraint(equalTo: buttonToCreateANewProject.bottomAnchor),
          
          tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),  tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
          
            
        ])
    }
    
    // MARK: - Button functions
    @objc func createNewProject(){
        projectListViewModel?.coordinator?.eventOccurred(with: .goToProjectCreation)
        
//        projectListViewModel?.createAProject()
//        self.tableView.reloadData()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        projectListViewModel?.fetchProjectViewModel()
        tableView.reloadData()
    }

}


// MARK: - Extension para a tableView
extension ProjectListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var configure = UIListContentConfiguration.cell()
        configure.text = filteredData[indexPath.row]
//        configure.secondaryText = projectListViewModel?.project?[indexPath.row].descript
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let project = projectListViewModel?.project[indexPath.row] {
            projectListViewModel?.goToTaskList(project)
        }
        
    }
    
}

extension ProjectListView: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    filteredData = []

    if searchText == "" {
        if let projectListViewModel = projectListViewModel, let project = projectListViewModel.project {
            for name in project {
                if let projectName = name.name {
                    filteredData.append(projectName)
                }
            }
        }
    }

    if let projectListViewModel = projectListViewModel, let project = projectListViewModel.project {
        for name in project {
            if let projectName = name.name {
              if projectName.uppercased().contains(searchText.uppercased()){
                filteredData.append(projectName)
              }
            }
        }
    }
    
    self.tableView.reloadData()
    
  }
  
}
