//
//  TaskEditionViewModel.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 09/10/23.
//

import Foundation

class TaskEditionViewModel: Coordinating {
  
  var coordinator: Coordinator?
  var view: TaskEditionView?
  private let projectManager = TaskManager()
  
  var name: String?
  var icon: String?
  var start: Date?
  var end: Date?
  var priority: String?
  var description: String?
  var red: Double?
  var green: Double?
  var blue: Double?
  
  var task: Task?{
    didSet{
      self.name = task?.name
      self.icon = task?.icon
      self.start = task?.start
      self.end = task?.end
      self.priority = task?.priority
      self.description = task?.descript
      self.red = task?.red
      self.green = task?.green
      self.blue = task?.blue
    }
  }

  func removeTopView() {
      coordinator?.eventOccurred(with: .removeTopView)
  }
  
  func deleteTask() {
    projectManager.deleteTask(task: task!)
  }
  
  func editTask() {
    projectManager.editTask(name: name!, icon: icon!, startDate: start!, endDate: end!, priority: priority!, descript: description!, red: red!, green: green!, blue: blue!, task: task!)
  }
  
  func compareDates() -> ComparisonResult{
      let compareDate = (start?.compare((end)!))!
      return compareDate
  }
  
  func selectedIcon(_ icon: String) {
    self.icon = icon
  }
  
}
