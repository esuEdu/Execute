//
//  TaskViewModel.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 24/09/23.
//

import Foundation

class TaskViewModel: Coordinating {
  
  var coordinator: Coordinator?
  var view: TaskView?
  
  private let taskManager = TaskManager()
  
  var task: [Task] = []
  
  init(){
    fetchTasks()
  }
  
  func fetchTasks() {
    let tasks = taskManager.fetchTask()
    self.task = tasks
  }
  
  func editTask(id: UUID, name: String, startDate: Date, endDate: Date, priority: Priority.RawValue, descript: String){
    taskManager.editTask(id: id, name: name, startDate: startDate, endDate: endDate, priority: priority, descript: descript)
    fetchTasks()
  }
  
  func deleteTask(id: UUID) {
    taskManager.deleteTask(id: id)
    fetchTasks()
  }
  
  func goToCreateTasks() {
    coordinator?.eventOccurred(with: .goToCreateTaskView)
  }
  
}
