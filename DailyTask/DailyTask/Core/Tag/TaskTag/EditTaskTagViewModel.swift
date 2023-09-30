//
//  EditTaskTagViewModel.swift
//  DailyTask
//
//  Created by Luca on 27/09/23.
//

import Foundation

class EditTaskTagViewModel: Coordinating {
    
    var coordinator: Coordinator?
    var view: EditTaskTagView?
    
    var tagTask: [TagTask] = []
    
    let taskTagManager = TaskTagManager()
    
    init(){
      fetchTagTasks()
    }
    
    func fetchTagTasks(){
        let tagTasks = taskTagManager.fetchTagTask()
        self.tagTask = tagTasks
    }
    
    func editTagTask(id: UUID, name: String, red: CGFloat, green: CGFloat, blue: CGFloat) {
        taskTagManager.editTagTask(id: id, name: name, red: Double(red), green: Double(green), blue: Double(blue))
        fetchTagTasks()
    }
    
    func deleteTagTask(id: UUID) {
        taskTagManager.deleteTagTask(id: id)
    }
    
    
}
