//
//  Coordinator.swift
//  DailyTask
//
//  Created by Eduardo on 20/09/23.
//

import Foundation
import UIKit

enum Event {
    case goToProjectCreation
    case goToProjectList
    case createModalView
    case goToTaskView
    case goToCreateTaskView
    case removeTopView
    case goToTaskTagView
    case goToProjectTagView
//    case goToEditTaskTagView
//    case goToEditProjectTagView
}

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func goToTaskCreation(_ project: Project)
    func eventOccurred(with type: Event)
    func goToTaskView(_ project: Project)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
    
}
