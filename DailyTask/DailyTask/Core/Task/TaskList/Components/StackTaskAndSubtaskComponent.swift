//
//  StackTaskAndSubtaskComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 08/10/23.
//

import UIKit

protocol StackTaskAndSubtaskComponentDelegate: AnyObject{
    func itWasPressed(_ task: Task)
    func wasItChecked(_ task: Task)
}

class StackTaskAndSubtaskComponent: UIView {
    
    weak var delegate: StackTaskAndSubtaskComponentDelegate?
    let stackview = UIStackView()
    let subtaskManager: SubTaskManager = SubTaskManager()
    let taskManager: TaskManager = TaskManager()
    var mainTask: TaskContainerComponent?
    let task: Task?
    var subtasks: [SubTask]?
    var color: UIColor?
    var index: Int = 0
    var completed: Int = 0
    
    init(task: Task){
        self.task = task
        super.init(frame: .zero)
        color = UIColor(red: task.red, green: task.green, blue: task.blue, alpha: 1)
        addSubview(stackview)
        mainTask = TaskContainerComponent(timeLabel: getCorrectDate() , taskName: task.name!, mainColor: color!, priority: task.priority!, isPressed: task.isDone)
        stackview.axis = .vertical
        stackview.addArrangedSubview(mainTask!)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 0, right: 16)
        mainTask?.delegate = self
        verifyThePersistence()
        getSubtask()
        createNewStacks()
        addAllContraints()
        if !task.isDone{
            verifyIfIsDone()
        }
        
        completed = index - 1
    }
    
    func getCorrectDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: task!.start!)
        return timeString
    }
    
    func verifyIfIsDone(){
        completed = 0
        for sub in stackview.arrangedSubviews{
            let r = sub as? SubtaskContainerComponent
            if let isDone = r?.subtask?.isDone{
                if isDone{
                    completed += 1
                }
            }
        }
        
        if completed != 0{
            mainTask?.undoneTheTask()
            mainTask?.roundedCheckbox.manualDisCheckCheckbox()
            taskManager.concludeTask(task!, isDone: false)
            let decimal = (Double(completed) / Double(index))
            let percent = Int((decimal) * 100)
            mainTask?.labelPercent.text = "\(percent)%"
            mainTask?.progressBar?.setProgress(decimal)
            if percent == 100{
                mainTask?.doneTheTask()
                if let task = task{
                    taskManager.concludeTask(task, isDone: true)
                }
                
            }
        } else if completed == 0{
            mainTask?.labelPercent.text = "0%"
            mainTask?.progressBar?.setProgress(0)
        }
        
    }
    
    func verifyThePersistence(){
        
        if let task = self.task {
            if task.isDone{
                mainTask!.doneTheTask()
            } else{
                
            }
        }
    }
    
    func getSubtask(){
        if let task = self.task{
            subtasks = subtaskManager.fetchSubTask(task: task)
        }
    }
    
    func createNewStacks(){
        for (index, sub) in self.subtasks!.enumerated(){
            let subtask = SubtaskContainerComponent(taskName: sub.name ?? "Sem titulo" , mainColor: color ?? .completeProgressLine, subtask: sub, isDone: sub.isDone)
            subtask.delegate = self
            self.stackview.addArrangedSubview(subtask)
            self.index = index + 1
        }
        
    }
    
    func addAllContraints(){
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StackTaskAndSubtaskComponent: SubtaskContainerComponentDelegate{
    func isChecked(_ check: Bool, sub: SubTask) {
        subtaskManager.ToggleIsDoneSubTask(subtask: sub, isDone: check)
        verifyIfIsDone()
        print("To aqui")
    }
    
    
}
extension StackTaskAndSubtaskComponent: TaskContainerComponentDelegate{
    
    func wasChecked(_ check: Bool) {
        delegate?.wasItChecked(task!)
        
        for subtask in subtasks!{
            subtaskManager.ToggleIsDoneSubTask(subtask: subtask, isDone: check)
        }
        
        if check{
            for n in stackview.arrangedSubviews{
                let r = n as? SubtaskContainerComponent
                r?.checkIfNeeded()
            }
        } else{
            for n in stackview.arrangedSubviews{
                let r = n as? SubtaskContainerComponent
                r?.discheckIfNeeded()
            }
        }
        
    }
    
    func itWasPressed() {
        if let task = self.task{
            delegate?.itWasPressed(task)
        }
        
    }
    
    func valueChanged() -> CGFloat {
        return 0.1
    }

    
}
