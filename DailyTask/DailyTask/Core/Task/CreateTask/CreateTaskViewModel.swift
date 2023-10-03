//
//  CreateTaskViewModel.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 25/09/23.
//

import Foundation
import UIKit

class CreateTaskViewModel: Coordinating  {
  
  var coordinator: Coordinator?
    var project: Project?
  
  var viewCreate: CreateTaskView?
  
  private let taskManager = TaskManager()
  private let subTaskManager = SubTaskManager()
  
    func createTask(name: String, startDate: Date, endDate: Date, priority: String, descript: String, red: Double, green: Double, blue: Double, subtasks: [String]){
        if let project = project{
            let task = taskManager.createTask(name: name, startDate: startDate, endDate: endDate, priority: priority, descript: descript, project: project, red: red, green: green, blue: blue)
            for sub in subtasks{
                addNewSubtask(name: sub, task: task)
                subTaskManager.save()
            }
        }
    }
  
  func removeLastView(){
      coordinator?.eventOccurred(with: .removeTopView)
  }
    
    func addNewSubtask(name: String, task: Task){
        let subtask = SubTask()
        subtask.id = UUID()
        subtask.isDone = false
        subtask.name = name
    }
    
}
