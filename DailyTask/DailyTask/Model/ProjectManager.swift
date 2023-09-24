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
    
    #warning("Change it when the project creation will be finished")
    func createAProject(){
        let project: Project = Project(context: context)
        project.id = UUID()
        project.icon = "😱"
        project.name = "Nome genérico"
        project.descript = "Descrição genérica"
        project.methodology = Methodologies.CBL.rawValue
        project.start = Date()
        project.end = Calendar.current.date(byAdding: .day, value: 2, to: Date())
        salvarDados()
    }
    
    func deleteAProject(project: Project){
        context.delete(project)
        salvarDados()
    }
}
