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
  var viewCreate: CreateTaskView?
  
  private let taskManager = TaskManager()
  
  var task: [Task] = []
  
  func fetchTasks() {
    let tasks = taskManager.fetchTask()
    self.task = tasks
  }
  
  func createTask(name: String, startDate: Date, endDate: Date, priority: String, descript: String){
    taskManager.createTask(name: name, startDate: startDate, endDate: endDate, priority: priority, descript: descript)
    fetchTasks()
  }
  
  func editTask(id: UUID, name: String, startDate: Date, endDate: Date, priority: String, descript: String){
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
