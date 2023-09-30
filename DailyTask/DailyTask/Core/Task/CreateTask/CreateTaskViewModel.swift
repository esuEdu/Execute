//
//  CreateTaskViewModel.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 25/09/23.
//

import Foundation

class CreateTaskViewModel: Coordinating  {
  
  var coordinator: Coordinator?
    var project: Project?
  
  var viewCreate: CreateTaskView?
  
  private let taskManager = TaskManager()
  
  func createTask(name: String, startDate: Date, endDate: Date, priority: String, descript: String){
      taskManager.createTask(name: name, startDate: startDate, endDate: endDate, priority: priority, descript: descript, project: project!)
  }
  
  func goToTasksView() {
    coordinator?.eventOccurred(with: .goToTaskView)
  }
  
  func removeLastView(){
    coordinator?.eventOccurred(with: .removeTopView)
  }
  
}
