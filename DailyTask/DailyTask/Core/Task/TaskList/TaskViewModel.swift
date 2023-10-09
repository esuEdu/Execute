//
//  TaskViewModel.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 24/09/23.
//

import Foundation

class TaskViewModel: Coordinating {
     
    var coordinator: Coordinator?
    var project: Project?
    var view: TaskView?
    
    var step: steps?
    var date: Date = Date.now
    
    private let taskManager = TaskManager()
    
    var task: [Task] = []
    
    init(project: Project){
        self.project = project
        fetchTasks(project: self.project!)
    }
    
    func fetchTasks(project: Project) {
        let tasks = taskManager.fetchTask(self.project!)
        self.task = tasks
    }
    
    func fetchTasks() {
        fetchTasks(project: project!)
    }
    
    func goToCreateTasks() {
        coordinator?.goToTaskCreation(project!, step)
    }
    
    func getActualTask(index: Int) -> Task{
        return task[index]
    }
    
    func goToModalGetInfo(_ task: Task, delegate: ModalGetInfoTaskViewDelegate){
        coordinator?.goToModalGetInfo(task, delegate)
    }
    
    
    func selectedStep(_ step:steps){
        self.step = step
    }
}

