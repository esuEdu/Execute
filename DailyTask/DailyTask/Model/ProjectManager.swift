//
//  ProjectManager.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import Foundation
import UIKit

/// Managing the Core Data project data with the basics operations create, save, fetch, delete and update.
class ProjectManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Basics operations
    func fetchProjects() -> [Project]{
        do{
            let request = Project.fetchRequest()
            
            return try context.fetch(request)
        } catch {
            fatalError("Problema na requisição de projetos")
        }
    }
    
    func salvarDados(){
        do {
            try context.save()
        } catch {
            fatalError("Erro na criação de um projeto")
        }
    }
    
    func createAProject(icon: String, name: String, description: String, methodology: Methodologies, start: Date, end: Date, red: Double, green: Double, blue: Double){
        let project: Project = Project(context: context)
        project.id = UUID()
        project.icon = icon
        project.name = name
        project.descript = description
        project.methodology = methodology.rawValue
        project.start = start
        project.end = end
        project.red = red
        project.green = green
        project.blue = blue
        salvarDados()
    }
    
    func deleteAProject(project: Project){
        context.delete(project)
        salvarDados()
    }
}
