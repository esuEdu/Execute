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
    private var projectManager = ProjectManager()
    
    var icon: String?
    var name: String?
    var description: String?
    var methodology: Methodologies?
    var start: Date?
    var end: Date?
    var colors: [CGFloat]?
    
    init(){
        icon = "trophy"
        name = "Sem nome"
        description = "Sem descrição"
        methodology = .CBL
        start = Date.now
        end = Date.now.addingTimeInterval(30)
    }
    
    func createAProject(){
        projectManager.createAProject(icon: icon!, name: name!, description: description!, methodology: methodology!, start: start!, end: end!, red: Double(colors?[0] ?? 0), green: Double(colors?[1] ?? 0) , blue: Double(colors?[2] ?? 0))
    }
    
    func goToProjectList(){
        coordinator?.eventOccurred(with: .goToProjectList)
    }
    
    func goToTagCreation(){
//        coordinator?.eventOccurred(with: )
    }
    
    func removeTopView(){
        coordinator?.eventOccurred(with: .removeTopView)
    }
    
    func compareDates() -> ComparisonResult{
        let buuu = (start?.compare((end)!))!
        return buuu
    }
}
