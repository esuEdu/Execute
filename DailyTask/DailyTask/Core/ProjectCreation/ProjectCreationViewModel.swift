//
//  ProjectCreationViewModel.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import Foundation

class ProjectCreationViewModel: Coordinating {
    var coordinator: Coordinator?
    var projectCreationView: ProjectCreationView?
    var projectManager = ProjectManager()
    var SFSymbols: [String] = ["pencil.tip", "lasso", "paperplane.fill", "xmark.bin.fill", "figure.soccer", "baseball", "trophy"]
    
    func createAProject(icon: String, name: String, description: String, methodology: Methodologies, start: Date, end: Date){
        projectManager.createAProject(icon: icon, name: name, description: description, methodology: methodology, start: start, end: end)
    }
}
