//
//  MainCoordinator.swift
//  DailyTask
//
//  Created by Eduardo on 20/09/23.
//

import Foundation
import UIKit

/// A coordinator responsible for managing navigation and flow in the application.
///
/// `MainCoordinator` conforms to the `Coordinator` protocol, allowing it to coordinate
/// various events and navigation transitions within the app.
///
/// ## Event Handling
///
/// The `MainCoordinator` class handles different types of events by implementing the
/// `eventOccurred(with:)` method from the `Coordinator` protocol. It responds to events
/// such as button taps and transitions to specific views based on the event type.
///
/// ## Starting the Coordinator
///
/// To start the coordinator, call the `start()` method, which initializes the initial view
/// and sets up the initial state of the navigation controller.
///
/// ### Example Usage
///
/// ```swift
/// let coordinator = MainCoordinator()
/// coordinator.navigationController = UINavigationController()
/// coordinator.start()
/// ```
class MainCoordinator: Coordinator {
    
    /// The navigation controller managed by the coordinator.
    var navigationController: UINavigationController?
    
    /// Handles various events by implementing the `eventOccurred(with:)` method.
    ///
    /// This method responds to different types of events, such as button taps and view
    /// transitions, and takes appropriate actions based on the event type.
    ///
    /// - Parameter type: The type of event that occurred.
    func eventOccurred(with type: Event) {
        
        switch type {
            
            // Handle the case when a button is tapped
        case .buttonTapped:
            let vc: TableViewCellViewController & Coordinating = TableViewCellViewController()
            vc.coordinator = self
            let vm = TestViewModel()
            vc.testViewModel = vm
            vm.testView = vc
            navigationController?.pushViewController(vc, animated: true)
            
        case .goToSubTaskList:
            let view: SubTaskTableView = SubTaskTableView()
            let viewModel: SubTaskListViewModel & Coordinating = SubTaskListViewModel()
            view.viewModel = viewModel
            viewModel.coordinator = self
            viewModel.view = view
            navigationController?.pushViewController(view, animated: true)
          
        case .goToTaskView:
          let view: TaskView = TaskView()
          let viewModel: TaskViewModel & Coordinating = TaskViewModel()
          view.viewModel = viewModel
          viewModel.view = view
          viewModel.coordinator = self
          navigationController?.pushViewController(view, animated: true)
          
        case .goToCreateTaskView:
          let view: CreateTaskView = CreateTaskView()
          let viewModel: TaskViewModel & Coordinating = TaskViewModel()
          view.viewModel = viewModel
          viewModel.viewCreate = view
          viewModel.coordinator = self
          navigationController?.present(view, animated: true)
          
        }
        
    }
    
    /// Initializes the coordinator and sets up the initial view and state.
    ///
    /// Call this method to start the coordinator and configure the initial state of the
    /// navigation controller. This method sets up the initial view and state of the app.
    func start() {
        let homeView: HomeView = HomeView()
        let homeViewModel: HomeViewModel & Coordinating = HomeViewModel()
        homeViewModel.coordinator = self
        homeView.homeViewModel = homeViewModel
        homeViewModel.homeView = homeView
        navigationController?.setViewControllers([homeView], animated: false)
    }
}
