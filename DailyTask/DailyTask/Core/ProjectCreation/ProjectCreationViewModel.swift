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
    
    var icon: String?
    var name: String?
    var description: String?
    var methodology: Methodologies?
    var start: Date?
    var end: Date?
    
    init(){
        icon = "trophy"
        name = "Sem nome"
        description = "Sem descrição"
        methodology = .CBL
        start = Date()
        end = Date()
    }
    
    func createAProject(){
        projectManager.createAProject(icon: icon!, name: name!, description: description!, methodology: methodology!, start: start!, end: end!)
    }
    
    func goToProjectList(){
        coordinator?.eventOccurred(with: .goToProjectList)
    }
    
    func removeTopView(){
        coordinator?.eventOccurred(with: .removeTopView)
    }
}
