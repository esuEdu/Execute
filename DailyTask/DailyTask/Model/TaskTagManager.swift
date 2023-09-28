//
//  TaskTagManager.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import Foundation
import UIKit
import CoreData

class TaskTagManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func createTagTask(name: String, red: CGFloat, green: CGFloat, blue: CGFloat) {
        let tagTask = TagTask(context: context)
        tagTask.id = UUID()
        tagTask.name = name
        tagTask.red = red
        tagTask.green = green
        tagTask.blue = blue
        do {
            try context.save()
            print("Task Tag created with succesfully")
        }catch {
            fatalError("Error in createTagTask \(error)")
        }
    }
    
    func fetchTagTask() -> [TagTask] {
        do{
            let tagTasks = try context.fetch(TagTask.fetchRequest())
            print("")
            return tagTasks
        }catch {
            fatalError("Error in fetchTagTask \(error)")
        }
    }
    
    func editTagTask(id: UUID, name: String, red: Double, green: Double, blue: Double) {
        do {
            // Fetch the project tag you want to edit by its ID
            let fetchRequest: NSFetchRequest<TagTask> = TagTask.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

            let tagTasks = try context.fetch(fetchRequest)

            // Check if a project tag with the specified ID exists
            guard let tagTaskToEdit = tagTasks.first else {
                print("Task Tag with ID \(id) not found.")
                return
            }

            // Update the properties of the fetched project tag
            tagTaskToEdit.name = name
            tagTaskToEdit.red = red
            tagTaskToEdit.green = green
            tagTaskToEdit.blue = blue

            // Save the context to persist the changes
            try context.save()

            print("Task Tag with ID \(id) edited successfully.")
        } catch {
            fatalError("Error in editTagTask: \(error)")
        }
    }
    
    func deleteTagTask(id: UUID) {
        do {
            // Fetch the project tag you want to edit by its ID
            let fetchRequest: NSFetchRequest<TagTask> = TagTask.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

            let tagTasks = try context.fetch(fetchRequest)

            // Check if a project tag with the specified ID exists
            guard let tagTaskToDelete = tagTasks.first else {
                print("Task Tag with ID \(id) not found.")
                return
            }
            
            context.delete(tagTaskToDelete)

            // Save the context to persist the changes
            try context.save()

            print("Task Tag with ID \(id) deleted successfully.")
        } catch {
            fatalError("Error in deleteTagTask: \(error)")
        }
    }
    
}
