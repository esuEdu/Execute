//
//  StackTaskAndSubtaskComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 08/10/23.
//

import UIKit

class StackTaskAndSubtaskComponent: UIStackView {
    
    let subtaskManager: SubTaskManager = SubTaskManager()
    let mainTask = TaskContainerComponent()
    let task: Task?
    var subtasks: [SubTask]?
    
    init(task: Task){
        self.task = task
        super.init(frame: .zero)
        axis = .vertical
        addArrangedSubview(mainTask)
        getSubtask()
        
        mainTask.isUnique = false
    }
    
    func getSubtask(){
        if let task = self.task{
            subtasks = subtaskManager.fetchSubTask(task: task)
        }
    }
    
    func createNewStacks(){
        var color = UIColor.systemBlue
        var text = "------"
        if let task = self.task{
            color = UIColor(red: task.red, green: task.green, blue: task.blue, alpha: 1)
            text = task.name ?? "------"
        }
        let subtask = SubtaskContainerComponent(taskName: text, mainColor: color)
        self.addArrangedSubview(subtask)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
