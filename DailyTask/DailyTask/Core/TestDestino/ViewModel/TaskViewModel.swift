//
//  TaskViewModel.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import Foundation

class TaskViewModel {
    var taskView: TableViewCellViewController?
    var subTaskManager = SubTaskManager()
    lazy var subTasks: [SubTask] = {
        
        return self.subTaskManager.fetchSubTask()
    }()
    
     var title: String {
        return subTasks.first?.name ?? "nao funciona tenta novamente"
    }
    
    func edit() {
        if let id = subTasks.first?.id {
            subTaskManager.editSubTask(id: id, name: "blafoi", startDate: Date(), endDate: Date())
        }else {
            return
        }
    }
    
}
