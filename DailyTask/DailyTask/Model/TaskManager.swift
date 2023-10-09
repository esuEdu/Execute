//
//  TaskManager.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import Foundation
import UIKit
import CoreData

class TaskManager {
  
  private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  func fetchTask(_ project: Project) -> [Task] {
    do {
      
      let request: NSFetchRequest<Task> = Task.fetchRequest()
      
      request.predicate = NSPredicate(format: "project == %@", project)
      
      
      let tasks = try context.fetch(request)
      
      return tasks
      
    } catch {
      fatalError("error in fetchTask \(error)")
    }
  }
  
  func fetchTask() -> [Task] {
    do {
      
      let request: NSFetchRequest<Task> = Task.fetchRequest()
      
      
      let tasks = try context.fetch(request)
      
      return tasks
      
    } catch {
      fatalError("error in fetchTask \(error)")
    }
  }
  
  func saveData(){
    do {
      try context.save()
    } catch {
      fatalError("Error in save the data of tasks")
    }
  }
  
  func createTask(name: String, startDate: Date, endDate: Date, priority: String, descript: String, project: Project, red: Double, green: Double, blue: Double, step: steps?, icon: String) -> Task{
    let task = Task(context: context)
    task.id = UUID()
    task.name = name
    task.start = startDate
    task.end = endDate
    task.descript = descript
    task.priority = priority
    if let step = step {
      task.step = step.rawValue
    }
    task.project = project
    task.isDone = false
    task.red = red
    task.green = green
    task.blue = blue
    task.icon = icon
    
    saveData()
    return task
  }
  
#warning("Verificar se no editar precisa de isDone")
  func editTask(name: String, icon: String, startDate: Date, endDate: Date, priority: String, descript: String, red: Double, green: Double, blue: Double, task: Task) {
    
    task.id = UUID()
    task.name = name
    task.icon = icon
    task.start = startDate
    task.end = endDate
    task.priority = priority
    task.descript = descript
    task.red = red
    task.green = green
    task.blue = blue
    
    saveData()
    
  }
  
  func deleteTask(task: Task) {
    context.delete(task)
    saveData()
  }
  
  func concludeTask(_ task: Task){
    do{
      task.isDone.toggle()
      try context.save()
    } catch{
      fatalError("Erro in complete or descomplete: \(error)")
    }
  }
  
  
  
}
