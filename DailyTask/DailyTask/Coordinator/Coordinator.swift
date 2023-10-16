//
//  Coordinator.swift
//  DailyTask
//
//  Created by Eduardo on 20/09/23.
//

import Foundation
import UIKit

enum Event {
  case goToProjectList
  case createModalView
  case removeTopView
}

protocol Coordinator {
  var tabBarController: UITabBarController? { get set }
  var navigationController: UINavigationController? { get set }
    func goToTaskCreation(_ project: Project, _ step: steps?, _ date: Date?)
  func goToProjectEditionView(_ project: Project,  isEditable: Bool)
    func goToModalGetInfo(_ task: Task, _ delegate: ModalGetInfoTaskViewDelegate, project: Project)
    func goToTaskEditionView(_ task: Task, project: Project)
  func goToProjectCreation(delegate: ProjectCreationViewDelegate)
  func eventOccurred(with type: Event)
  func goToTaskView(_ project: Project)
  func start()
}

protocol Coordinating {
  var coordinator: Coordinator? { get set }
}
