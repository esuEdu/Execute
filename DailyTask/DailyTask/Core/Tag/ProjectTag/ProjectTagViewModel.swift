//
//  ProjectTagViewModel.swift
//  DailyTask
//
//  Created by Luca on 27/09/23.
//

import Foundation

class ProjectTagViewModel: Coordinating {
    
    var coordinator: Coordinator?
    var view: ProjectTagView?
    
    var tagProject: [TagProject] = []
    
    let projectTagManager = ProjectTagManager()
    
    init(){
      fetchTagProjects()
    }
    
    func fetchTagProjects(){
        let tagProjects = projectTagManager.fetchTagProject()
        self.tagProject = tagProjects
    }
    
    func createTagProject(name: String, red: CGFloat, green: CGFloat, blue:CGFloat) {
        projectTagManager.createTagProject(name: name, red: Double(red), green: Double(green), blue: Double(blue))
        fetchTagProjects()
    }
    
    func deleteTagProject(id: UUID) {
        projectTagManager.deleteTagProject(id: id)
    }
    
    
    
    
}
