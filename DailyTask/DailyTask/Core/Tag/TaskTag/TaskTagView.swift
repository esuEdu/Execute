//
//  TaskTagView.swift
//  DailyTask
//
//  Created by Luca on 27/09/23.
//

import UIKit

class TaskTagView: UIViewController, UISheetPresentationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var viewModel: TaskTagViewModel?
    
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = String(localized: "PlaceholderNameTask", comment: "Placeholder text name task")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let buttonDone: UIBarButtonItem = {
      let button = UIBarButtonItem()
      button.title = String(localized: "Done")
      return button
    }()
    
    private let tableView: UITableView = {
      let tableView = UITableView(frame: .zero, style: .plain)
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellTask")
      
      return tableView
    }()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        sheetPresentationController?.delegate = self
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.preferredCornerRadius = 10
        sheetPresentationController?.detents = [.large()]
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        title = "All Task Tags"
        
        view.addSubview(nameTextField)
        
        nameTextField.returnKeyType = .done
        nameTextField.autocapitalizationType = .none
        nameTextField.autocorrectionType = .no
        nameTextField.keyboardAppearance = .default
        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        
        navigationItem.rightBarButtonItem = buttonDone
        
        buttonDone.target = self
        buttonDone.action = #selector(createTaskTag)
        
        addConstraintsTableView()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      refreshTableView()
    }
      
    func addConstraintsTableView() {
      NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      ])
    }
    
    func setConstraints() {
    
      NSLayoutConstraint.activate([
      
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        
      ])
    }

    
}

extension TaskTagView: UITableViewDelegate, UITableViewDataSource {
  
  @objc func refreshTableView(){
    viewModel?.fetchTagTasks()
    self.tableView.reloadData()
  }
  
//  @objc func addTask() {
//    viewModel?.goToCreateTasks()
//  }
  
  // MARK: BASIC SETTING FOR TABLEVIEW
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.tagTask.count ?? 0
  }
  
  // MARK: BASIC SETTING FOR TABLEVIEW
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let tagTask = viewModel?.tagTask[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask")!
    
    var configure = UIListContentConfiguration.cell()
    configure.text = tagTask?.name
    
    cell.contentConfiguration = configure
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
      let actionDelete = UIContextualAction(style: .destructive, title: "Delete") {
      (action, view, completionHandler) in
      
      let tagTaskToRemove = self.viewModel?.tagTask[indexPath.row].id
      
      self.viewModel?.deleteTagTask(id: tagTaskToRemove!)
      self.tableView.reloadData()
    
    }
      

    return UISwipeActionsConfiguration(actions: [actionDelete])
  }
    
    @objc func createTaskTag() {
        self.viewModel?.createTagTask(name: self.nameTextField.text != "" ? self.nameTextField.text! : "Sem nome", red: 0, green: 0, blue: 0)
        self.viewModel?.fetchTagTasks()
      
//      viewModel?.removeLastView()
    }
    
//    @objc func cancelTask(){
//      viewModel?.removeLastView()
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
      print("inside of textViewDidBeginEditing")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
      print("inside of textViewDidEndEditing")
    }
  
}
