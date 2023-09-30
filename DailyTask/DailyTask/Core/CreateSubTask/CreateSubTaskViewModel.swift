//
//  CreateSubTaskViewModel.swift
//  DailyTask
//
//  Created by Eduardo on 25/09/23.
//

import Foundation

class CreateSubTaskViewModel: Coordinating {
    
    var coordinator: Coordinator?
    var view: CreateSubTaskView?
    
    let subTaskManager = SubTaskManager()
    
    var name: String?
    var startDate: Date?
    
    func createSubTask() {
        subTaskManager.createSubTask(name: self.name ?? "Sub-Task", startDate: self.startDate ?? Date.now)
    }
    
}
