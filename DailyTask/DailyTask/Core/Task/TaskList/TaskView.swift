//
//  TaskView.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 24/09/23.
//

import Foundation
import UIKit

class TaskView: UIViewController {
  
  var viewModel: TaskViewModel?
  
  var formatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .short
    return dateFormatter
  }()

  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellTask")
    
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(tableView)
    view.backgroundColor = .white
    tableView.delegate = self
    tableView.dataSource = self
    title = "All Tasks"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    
    addConstraintsTableView()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    refreshTableView()
  }
    
  func addConstraintsTableView() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
  
}

extension TaskView: UITableViewDelegate, UITableViewDataSource {
  
  @objc func refreshTableView(){
    viewModel?.fetchTasks()
    self.tableView.reloadData()
  }
  
  @objc func addTask() {
    viewModel?.goToCreateTasks()
  }
  
  // MARK: BASIC SETTING FOR TABLEVIEW
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.task.count ?? 0
  }
  
  // MARK: BASIC SETTING FOR TABLEVIEW
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let task = viewModel?.task[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask")!
    
    let data = self.formatter.string(from: task?.end ?? Date.now)
    
    var configure = UIListContentConfiguration.cell()
    configure.text = task?.name
    configure.secondaryText = task?.descript
    
    cell.contentConfiguration = configure
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let actionDelete = UIContextualAction(style: .destructive, title: "Delete") {
      (action, view, completionHandler) in
      
      let taskToRemove = self.viewModel?.task[indexPath.row].id
      
      self.viewModel?.deleteTask(id: taskToRemove!)
      self.tableView.reloadData()
    
    }

    return UISwipeActionsConfiguration(actions: [actionDelete])
  }
  
}

#Preview {
  TaskView()
}
