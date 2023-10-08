//
//  ProjectEditionViewModel.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 05/10/23.
//

import Foundation

class ProjectEditionViewModel: Coordinating {
    var project: Project?{
        didSet{
            self.icon = project?.icon
            self.name = project?.name
            self.description = project?.descript
            self.methodology = project?.methodology
            self.start = project?.start
            self.end = project?.end
            self.red = project?.red
            self.green = project?.green
            self.blue = project?.blue
        }
    }
    var coordinator: Coordinator?
    var view: ProjectEditionView?
    private var projectManager = ProjectManager()
    
    var icon: String?
    var name: String?
    var description: String?
    var methodology: String?
    var start: Date?
    var end: Date?
    var red: Double?
    var green: Double?
    var blue: Double?
    
    func removeTopView(){
        coordinator?.eventOccurred(with: .removeTopView)
    }
    
    func removeProject(){
        projectManager.deleteAProject(project: project!)
    }
    
    func editProject(){
        projectManager.editAProject(icon: icon!, name: name!, description: description!, methodology: methodology!, start: start!, end: end!, red: red!, green: green!, blue: blue!, project: project!)
    }
    
    func selectedMethodology(_ met:Methodologies){
        methodology = met.rawValue
    }
    
    func compareDates() -> ComparisonResult{
        let buuu = (start?.compare((end)!))!
        return buuu
    }
    
    func selectedIcon(_ icon: String){
        self.icon = icon
        
    }
    
}

