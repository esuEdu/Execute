//
//  TaskViewModel.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 24/09/23.
//

import Foundation

class TaskViewModel: Coordinating {
  
  var coordinator: Coordinator?
    var project: Project?
  var view: TaskView?
  
  private let taskManager = TaskManager()
  
  var task: [Task] = []
  
    init(project: Project){
        self.project = project
        fetchTasks(project: self.project!)
    }
  
    func fetchTasks(project: Project) {
        let tasks = taskManager.fetchTask(self.project!)
    self.task = tasks
  }
  
    func fetchTasks() {
        fetchTasks(project: project!)
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
    coordinator?.goToTaskCreation(project!)
  }
    
  
}
