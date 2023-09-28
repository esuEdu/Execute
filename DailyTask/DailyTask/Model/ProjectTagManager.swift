//
//  ProjectTagManager.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import Foundation
import UIKit
import CoreData

class ProjectTagManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func createTagProject(name: String, red: CGFloat, green: CGFloat, blue: CGFloat) {
        let tagProject = TagProject(context: context)
        tagProject.id = UUID()
        tagProject.name = name
        tagProject.red = red
        tagProject.green = green
        tagProject.blue = blue
        do {
            try context.save()
            print("Project Tag created with succesfully")
        }catch {
            fatalError("Error in createTagProject \(error)")
        }
    }
    
    func fetchTagProject() -> [TagProject] {
        do{
            let tagProjects = try context.fetch(TagProject.fetchRequest())
            print("")
            return tagProjects
        }catch {
            fatalError("Error in fetchTagProject \(error)")
        }
    }
    
    func editTagProject(id: UUID, name: String, red: CGFloat, green: CGFloat, blue: CGFloat) {
        do {
            // Fetch the project tag you want to edit by its ID
            let fetchRequest: NSFetchRequest<TagProject> = TagProject.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

            let tagProjects = try context.fetch(fetchRequest)

            // Check if a project tag with the specified ID exists
            guard let tagProjectToEdit = tagProjects.first else {
                print("Project Tag with ID \(id) not found.")
                return
            }

            // Update the properties of the fetched project tag
            tagProjectToEdit.name = name
            tagProjectToEdit.red = red
            tagProjectToEdit.green = green
            tagProjectToEdit.blue = blue

            // Save the context to persist the changes
            try context.save()

            print("Project Tag with ID \(id) edited successfully.")
        } catch {
            fatalError("Error in editTagProject: \(error)")
        }
    }
    
    func deleteTagProject(id: UUID) {
        do {
            // Fetch the project tag you want to edit by its ID
            let fetchRequest: NSFetchRequest<TagProject> = TagProject.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

            let tagProjects = try context.fetch(fetchRequest)

            // Check if a project tag with the specified ID exists
            guard let tagProjectToDelete = tagProjects.first else {
                print("Project Tag with ID \(id) not found.")
                return
            }
            
            context.delete(tagProjectToDelete)

            // Save the context to persist the changes
            try context.save()

            print("Project Tag with ID \(id) deleted successfully.")
        } catch {
            fatalError("Error in deleteTagProject: \(error)")
        }
    }
    
}
