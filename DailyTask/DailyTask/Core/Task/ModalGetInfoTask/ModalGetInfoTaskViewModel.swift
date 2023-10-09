//
//  ModalGetInfoTaskViewModel.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 01/10/23.
//

import Foundation
import UIKit

class ModalGetInfoTaskViewModel: Coordinating {
    
    var done: Bool = false
    var coordinator: Coordinator?
    var view: ModalGetInfoTaskView?
    var task: Task?
    
    private let taskManager = TaskManager()
  
    
    func getTaskName() -> String{
        return task?.name ?? "ERRO"
    }
    
    func getTaskStartTime() -> Date{
        return task?.start ?? Date.now
    }
    
    func getIconName() -> String {
        return task?.icon ?? "pencil.tip"
    }
    
    func getUIColor() -> UIColor {
        let red = task?.red ?? 0
        let blue = task?.blue ?? 0
        let green = task?.green ?? 0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func concludedTask(){
        if let task = task {
            taskManager.concludeTask(task)
        }
    }
    
    func deleteTask(){
        if let task = task {
          taskManager.deleteTask(task: task)
        }
    }
    
    func getHour() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" // Define o formato da hora

        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: (task?.start)!)
    }
    
    func getDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        return dateFormatter.string(from: (task?.start)!)
    }
  
  func goToEditView() {
    coordinator?.goToTaskEditionView(task!)
  }
  
  
  
}
