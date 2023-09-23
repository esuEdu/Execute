//
//  ProjectListViewModel.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import UIKit

class ProjectListViewModel: Coordinating {
    var coordinator: Coordinator?
    var projectView: ProjectListView?
    let project: [Project]?
    var projectManager = ProjectManager()
    
    init() {
        self.project = projectManager.fetchProjects()
    }
    
    func createAProject(){
        let project: Project = Project(context: projectManager.context)
        project.id = UUID()
        project.name = "Nome genérico"
        project.descript = "Descrição genérica"
        project.methodology = String.Methodologies.CBL.rawValue
        project.start = Date()
        project.end = Calendar.current.date(byAdding: .day, value: 2, to: Date())
        projectManager.salvarDados()
    }
    
    
}
