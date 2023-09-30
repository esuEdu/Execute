//
//  EditProjectTagViewModel.swift
//  DailyTask
//
//  Created by Luca on 27/09/23.
//

import Foundation

class EditProjectTagViewModel: Coordinating {
    
    var coordinator: Coordinator?
    var view: EditTaskTagView?
    
    var tagProject: [TagProject] = []
    
    let projectTagManager = ProjectTagManager()
    
    init(){
      fetchTagProjects()
    }
    
    func fetchTagProjects(){
        let tagProjects = projectTagManager.fetchTagProject()
        self.tagProject = tagProjects
    }
    
    func editTagProject(id: UUID, name: String, red: CGFloat, green: CGFloat, blue: CGFloat) {
        projectTagManager.editTagProject(id: id, name: name, red: Double(red), green: Double(green), blue: Double(blue))
        fetchTagProjects()
    }
    
    func deleteTagProject(id: UUID) {
        projectTagManager.deleteTagProject(id: id)
    }
    
    
}

