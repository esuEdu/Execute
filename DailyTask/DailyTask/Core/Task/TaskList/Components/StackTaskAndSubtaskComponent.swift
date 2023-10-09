//
//  StackTaskAndSubtaskComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 08/10/23.
//

import UIKit

protocol StackTaskAndSubtaskComponentDelegate: AnyObject{
    func itWasPressed(_ task: Task)
}

class StackTaskAndSubtaskComponent: UIView {
    
    weak var delegate: StackTaskAndSubtaskComponentDelegate?
    let stackview = UIStackView()
    let subtaskManager: SubTaskManager = SubTaskManager()
    var mainTask: TaskContainerComponent?
    let task: Task?
    var subtasks: [SubTask]?
    var color: UIColor?
    
    init(task: Task){
        self.task = task
        super.init(frame: .zero)
        color = UIColor(red: task.red, green: task.green, blue: task.blue, alpha: 1)
        addSubview(stackview)
        mainTask = TaskContainerComponent(timeLabel: getCorrectDate() , taskName: task.name!, mainColor: color!)
        stackview.axis = .vertical
        stackview.addArrangedSubview(mainTask!)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.layoutMargins = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
        mainTask?.delegate = self
        verifyThePersistence()
        getSubtask()
        createNewStacks()
        addAllContraints()
    }
    
    func getCorrectDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: task!.start!)
        return timeString
    }
    
    func verifyThePersistence(){
        if subtasks?.count == 0{
            mainTask!.isUnique = false
            layoutIfNeeded()
        } else{
            mainTask!.isUnique = true
            layoutIfNeeded()
        }
        
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
            let subtask = SubtaskContainerComponent(taskName: sub.name ?? "Sem titulo" , mainColor: color ?? .systemBlue)
            self.stackview.addArrangedSubview(subtask)
            
            if index == ((subtasks?.count ?? 0) - 1){
                subtask.secondLine.isHidden = true
            }
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
    
    func isChecked(_ check: Bool) {
        
    }
    
    
}
extension StackTaskAndSubtaskComponent: TaskContainerComponentDelegate{
    func itWasPressed() {
        if let task = self.task{
            delegate?.itWasPressed(task)
        }
        
    }
    
    func valueChanged() -> CGFloat {
        return 0.1
    }
    
    func isPressed() {
        
    }
    
}
