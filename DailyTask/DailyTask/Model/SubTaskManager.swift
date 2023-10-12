//
//  SubTaskManager.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import Foundation
import UIKit
import CoreData

class SubTaskManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchSubTask(task: Task) -> [SubTask] {
        do{
            let request: NSFetchRequest<SubTask> = SubTask.fetchRequest()
            
            request.predicate = NSPredicate(format: "task == %@", task)
            
            let subTasks = try context.fetch(request)
            
            return subTasks
        }catch {
            fatalError("erro in fetchSubTask \(error)")
        }
    }
    
    func createSubTask(name: String, task: Task){
        let subTask = SubTask(context: context)
        subTask.id = UUID()
        subTask.name = name
        subTask.isDone = false
        subTask.task = task
        save()
    }
    
    func save(){
        do {
            try context.save()
        } catch {
            fatalError("Error in editSubTask: \(error)")
        }
    }
    
    func editSubTask(id: UUID, name: String, startDate: Date, endDate: Date) {
        do {
            // Fetch the subtask you want to edit by its ID
            let fetchRequest: NSFetchRequest<SubTask> = SubTask.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

            let subTasks = try context.fetch(fetchRequest)

            // Check if a subtask with the specified ID exists
            guard let subTaskToEdit = subTasks.first else {

                return
            }

            // Update the properties of the fetched subtask
            subTaskToEdit.name = name
            subTaskToEdit.start = startDate

            // Save the context to persist the changes
            try context.save()

        } catch {
            fatalError("Error in editSubTask: \(error)")
        }
    }

    
    func ToggleIsDoneSubTask(subtask: SubTask, isDone: Bool) {
        do {
            subtask.isDone = isDone

            // Save the context to persist the changes
            try context.save()

        } catch {
            fatalError("Error in toggleIsDoneSubTask: \(error)")
        }
    }
    
    func deleteSubTask(id: UUID) {
        do {
            // Fetch the subtask you want to edit by its ID
            let fetchRequest: NSFetchRequest<SubTask> = SubTask.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

            let subTasks = try context.fetch(fetchRequest)

            // Check if a subtask with the specified ID exists
            guard let subTaskToDelete = subTasks.first else {
                return
            }
            
            context.delete(subTaskToDelete)

            // Save the context to persist the changes
            try context.save()

        } catch {
            fatalError("Error in deleteSubTask: \(error)")
        }
    }
    
    func concludeSubtask(_ subtask: SubTask){
        do{
            subtask.isDone.toggle()
            try context.save()
        } catch{
            fatalError("Erro in complete or descomplete: \(error)")
        }
    }
}
