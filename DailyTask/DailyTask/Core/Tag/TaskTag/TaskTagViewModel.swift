//
//  TaskTagViewModel.swift
//  DailyTask
//
//  Created by Luca on 27/09/23.
//

import Foundation

class TaskTagViewModel: Coordinating {
    
    var coordinator: Coordinator?
    var view: TaskTagView?
    
    var tagTask: [TagTask] = []
    
    let taskTagManager = TaskTagManager()
    
    init(){
      fetchTagTasks()
    }
    
    func fetchTagTasks(){
        let tagTasks = taskTagManager.fetchTagTask()
        self.tagTask = tagTasks
    }
    
    func createTagTask(name: String, red: CGFloat, green: CGFloat, blue: CGFloat) {
        taskTagManager.createTagTask(name: name, red: Double(red), green: Double(green), blue: Double(blue))
        fetchTagTasks()
    }
    
    #warning("Remove the delete as it won't be used here in the final version")
    func deleteTagTask(id: UUID) {
        taskTagManager.deleteTagTask(id: id)
    }
    
}
