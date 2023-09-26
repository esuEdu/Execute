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
    
    func createSubTask(name: String, startDate: Date, endDate: Date) {
        subTaskManager.createSubTask(name: name, startDate: startDate, endDate: endDate)
    }
    
}
