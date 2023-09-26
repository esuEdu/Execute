//
//  Coordinator.swift
//  DailyTask
//
//  Created by Eduardo on 20/09/23.
//

import Foundation
import UIKit

enum Event {
    case buttonTapped
    case goToProjectCreation
    case goToProjectList
    case goToSubTaskList
    case createModalView
  case goToTaskView
  case goToCreateTaskView
  case removeTopView
}

protocol Coordinator {
    var tabBarController: UITabBarController? { get set }
    var navigationController: UINavigationController? { get set }
    
    func eventOccurred(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
    
}
