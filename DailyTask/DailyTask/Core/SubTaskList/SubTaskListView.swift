//
//  SubTaskListView.swift
//  DailyTask
//
//  Created by Eduardo on 23/09/23.
//

import Foundation
import UIKit

class SubTaskTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var viewModel: SubTaskListViewModel?
    
    var tableView: UITableView = UITableView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableView.delegate = self
        tableView.dataSource = self
        title = "Tasks"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        
        
    }
    
    // MARK: ADD
    @objc func addTapped() {
        let alert = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)

        alert.addTextField()
        let ok = UIAlertAction(title: "OK", style: .default) { [self] (action) in
            
            _ = alert.textFields![0]
            viewModel?.createSubTask(name: "bla", startDate: Date(), endDate: Date())
            self.tableView.reloadData()
        }

        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (cancel) in

             //do nothing

        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: EDIT
    @objc func editTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)

        if tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        }
    }
    
    // MARK: MOVE
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel?.subTask.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    // MARK: SWIPE DELETE
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, success) in
//            self.viewModel?.subTask.remove(at: indexPath.row)
            
            if let id = viewModel?.subTask[indexPath.row].id {
                viewModel?.deleteSubTask(id: id)
            }
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }

        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
    
    // MARK: BASIC SETTING FOR TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.subTask.count ?? 0
    }
    
    // MARK: BASIC SETTING FOR TABLEVIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = viewModel?.subTask[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = task?.name
        return cell
    }
}

