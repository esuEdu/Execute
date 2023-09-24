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
    var project: [Project]!
    var projectManager = ProjectManager()
    
    init() {
        self.project = projectManager.fetchProjects()
    }
    
    func createAProject(){
        let project: Project = Project(context: projectManager.context)
        project.id = UUID()
        project.icon = "😱"
        project.name = "Nome genérico"
        project.descript = "Descrição genérica"
        project.methodology = Methodologies.CBL.rawValue
        project.start = Date()
        project.end = Calendar.current.date(byAdding: .day, value: 2, to: Date())
        projectManager.salvarDados()
        fetchProjectViewModel()
    }
    
    func deleteAProject(project: Project){
        projectManager.context.delete(project)
        projectManager.salvarDados()
        fetchProjectViewModel()
    }
    
    func fetchProjectViewModel(){
        self.project = projectManager.fetchProjects()
    }
    
    
}
