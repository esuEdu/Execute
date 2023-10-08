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
    
    func saveData(){
        do {
            try context.save()
        } catch {
            fatalError("Error in save the data of tasks")
        }
    }
    
    func createTask(name: String, startDate: Date, endDate: Date, priority: String, descript: String, project: Project, red: Double, green: Double, blue: Double, step: steps?) -> Task{
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
        
        saveData()
        return task
    }
    
#warning("Verificar se no editar precisa de isDone")
    func editTask(id: UUID, name: String, startDate: Date, endDate: Date, priority: String, descript: String) {
        
        do {
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            let tasks = try context.fetch(fetchRequest)
            
            guard let tasksToEdit = tasks.first else {
                print("Task with ID \(id) not found.")
                return
            }
            
            tasksToEdit.name = name
            tasksToEdit.start = startDate
            tasksToEdit.end = endDate
            tasksToEdit.priority = priority
            tasksToEdit.descript = descript
            
            try context.save()
            
            print("Task with ID \(id) edited successfully.")
        } catch {
            fatalError("Error in editTask: \(error)")
        }
        
    }
    
    func deleteTask(id: UUID) {
        do{
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            let tasks = try context.fetch(fetchRequest)
            
            guard let tasksToDelete = tasks.first else {
                print("Task with ID \(id) not found.")
                return
            }
            
            context.delete(tasksToDelete)
            
            try context.save()
            
            print("Task with ID \(id) deleted successfully.")
            
        } catch {
            fatalError("Error in deleteTask: \(error)")
        }
        
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
