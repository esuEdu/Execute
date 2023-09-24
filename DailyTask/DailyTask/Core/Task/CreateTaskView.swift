//
//  CreateTaskView.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 24/09/23.
//

import Foundation
import UIKit

class CreateTaskView: UIViewController {
  var viewModel: TaskViewModel?
  
  private let field: UITextField = UITextField()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Create Task"
    view.backgroundColor = .systemGray
    
    field.returnKeyType = .done
    field.autocapitalizationType = .words
    field.autocorrectionType = .no
    
    field.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(field)
  
    
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      field.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      field.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      field.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      field.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
    ])
  }
  
}

#Preview {
  CreateTaskView()
}
