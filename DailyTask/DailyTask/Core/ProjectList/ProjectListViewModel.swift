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
    
    func deleteAProject(project: Project){
        projectManager.deleteAProject(project: project)
        fetchProjectViewModel()
    }
    
    func fetchProjectViewModel(){
        self.project = projectManager.fetchProjects()
    }
    
    
}
