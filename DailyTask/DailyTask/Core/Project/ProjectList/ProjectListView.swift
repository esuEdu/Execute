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
  
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
  let buttonToCreateANewProject: UIButton = {
      let button = UIButton()
    button.setTitle("+ \(String(localized: "NewProjectKey"))", for: .normal)
    
      button.translatesAutoresizingMaskIntoConstraints = false
 
    var config = UIButton.Configuration.filled()
    
    config.baseBackgroundColor = .systemBlue
    config.background.cornerRadius = 10
    
    let spacing: CGFloat = 5
    config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
  
    button.configuration = config
    
    return button
  }()
  
  let searchBar: UISearchBar = {
    let search = UISearchBar()
    search.placeholder = String(localized: "SearchProjectsPlaceholder")
    search.translatesAutoresizingMaskIntoConstraints = false
    search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    
    return search
  }()
  
  let stackViewForHeader: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false

    return stackView
  }()
  
  let myProjectLabel: LabelComponent = {
    let label = LabelComponent(text: String(localized: "MyProjectKey"), accessibilityLabel: String(localized: "MyProjectKey"), font: .title1)
    label.translatesAutoresizingMaskIntoConstraints =  false
    label.textLabel.font = .boldTitle1
    return label
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
      
      view.addSubview(searchBar)
      view.addSubview(stackViewForHeader)
      view.addSubview(tableView)
      
      stackViewForHeader.addArrangedSubview(myProjectLabel)
      stackViewForHeader.addArrangedSubview(buttonToCreateANewProject)

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
          
          stackViewForHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          stackViewForHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
          stackViewForHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
          stackViewForHeader.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -10),
          
          searchBar.topAnchor.constraint(equalTo: stackViewForHeader.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
          searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),
          searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10),
          
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

#Preview{
  ProjectListView()
}
