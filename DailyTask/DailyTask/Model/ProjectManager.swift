//
//  ProjectManager.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import Foundation
import UIKit

class ProjectManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
}
