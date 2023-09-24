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
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
  
  }

}

extension TaskView: UITableViewDelegate, UITableViewDataSource {
  
  @objc func addTask() {
    viewModel?.goToCreateTasks()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    return cell
  }
 
}

#Preview {
  TaskView()
}
