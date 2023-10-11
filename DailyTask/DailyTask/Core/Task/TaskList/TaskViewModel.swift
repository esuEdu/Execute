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
    
    var step: steps = .Engage
    
    let currentDate = Date()

    let calendar = Calendar.current
    
    var date: Date = Date()
    
    let taskManager = TaskManager()
    let subtaskManager = SubTaskManager()
    
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
    
    func deleteTask(id: UUID) {
        taskManager.deleteTask(id: id)
        fetchTasks()
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
    
    func concludedTask(_ task: Task){
        taskManager.concludeTask(task)
        print("Cheguei")
    }
    
    func concludeSubtask(task: Task){
        let subtasks = subtaskManager.fetchSubTask(task: task)
        let isDone = task.isDone
        
        for subtask in subtasks {
            subtaskManager.ToggleIsDoneSubTask(subtask: subtask, isDone: isDone)
        }
        
    }
    
}

