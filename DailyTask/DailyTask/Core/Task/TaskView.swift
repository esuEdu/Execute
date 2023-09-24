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
  
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(tableView)
    view.backgroundColor = .white
    tableView.delegate = self
    tableView.dataSource = self
    title = "All Tasks"
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
  
  }

}

extension TaskView: UITableViewDelegate, UITableViewDataSource {
  
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
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
      cell.textLabel?.text = task?.name
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
      return cell
  }
 
}

#Preview {
  TaskView()
}
