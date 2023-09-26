//
//  SubTaskListViewModel.swift
//  DailyTask
//
//  Created by Eduardo on 23/09/23.
//

import Foundation

class SubTaskListViewModel: Coordinating {
    var view: SubTaskTableView?
    var coordinator: Coordinator?
    
    func goToModal() {
        coordinator?.eventOccurred(with: .createModalView)
    }
    
    private let subTaskManager = SubTaskManager()
    
    var subTask: [SubTask] = []
    
    func fetchSubTasks() {
        let subTasks = subTaskManager.fetchSubTask()
        subTask = subTasks
    }
    
    func editSubTask(id: UUID, name: String, startDate: Date, endDate: Date) {
        subTaskManager.editSubTask(id: id, name: name, startDate: startDate, endDate: endDate)
        fetchSubTasks()
    }
    
    func toggleIsDoneSubTask(id: UUID) {
        subTaskManager.ToggleIsDoneSubTask(id: id)
        fetchSubTasks()
    }
    
    func deleteSubTask(id: UUID) {
        subTaskManager.deleteSubTask(id: id)
        fetchSubTasks()
    }
}
