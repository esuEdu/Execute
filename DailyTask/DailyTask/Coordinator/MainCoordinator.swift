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
    
    var tabBarController: UITabBarController?
    
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
            
        case .goToProjectList:
            let projectListView: ProjectListView = ProjectListView()
            let projectListViewModel: ProjectListViewModel & Coordinating = ProjectListViewModel()
            projectListViewModel.coordinator = self
            projectListView.projectListViewModel = projectListViewModel
            projectListViewModel.projectView = projectListView
            navigationController?.pushViewController(projectListView, animated: true)
            
        case .removeTopView:
            navigationController?.popViewController(animated: true)
            
        case .createModalView:
            let view: CreateSubTaskView = CreateSubTaskView()
            let viewModel = CreateSubTaskViewModel()
            view.viewModel = viewModel
            viewModel.coordinator = self
            viewModel.view = view
            navigationController?.present(view, animated: true)
            
        }
        
    }
    
    func goToProjectCreation(delegate: ProjectCreationViewDelegate){
        let view: ProjectCreationView = ProjectCreationView()
        let viewModel: ProjectCreationViewModel & Coordinating = ProjectCreationViewModel()
        viewModel.coordinator = self
        viewModel.projectCreationView = view
        view.projectCreationViewModel = viewModel
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            navigationController?.pushViewController(view, animated: true)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            view.delegate = delegate
            navigationController?.present(view, animated: true)
        }
    }
    
    func goToProjectEditionView(_ project: Project, isEditable: Bool){
        let view: ProjectEditionView = ProjectEditionView()
        let viewModel: ProjectEditionViewModel & Coordinating = ProjectEditionViewModel()
        viewModel.coordinator = self
        viewModel.view = view
        viewModel.project = project
        view.isEditable = isEditable
        view.viewModel = viewModel
        navigationController?.pushViewController(view, animated: true)
    }
  
    func goToTaskEditionView(_ task: Task, project: Project){
    let view = TaskEditionView()
    let viewModel: TaskEditionViewModel & Coordinating = TaskEditionViewModel()
    viewModel.coordinator = self
    viewModel.view = view
        viewModel.project = project
    viewModel.task = task
    view.viewModel = viewModel
    navigationController?.pushViewController(view, animated: true)
  }
    
    func goToTaskView(_ project: Project){
        let view: TaskView = TaskView()
        let viewModel: TaskViewModel & Coordinating = TaskViewModel(project: project)
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.coordinator = self
        navigationController?.pushViewController(view, animated: true)
    }
    
  func goToTaskCreation(_ project: Project, _ step: steps?, delegate: TaskCreationViewDelegate){
        let view: CreateTaskView = CreateTaskView()
        let viewModel: CreateTaskViewModel & Coordinating = CreateTaskViewModel()
        viewModel.project = project
        viewModel.step = step
        view.viewModel = viewModel
        viewModel.viewCreate = view
        viewModel.coordinator = self
      
      if UIDevice.current.userInterfaceIdiom == .phone {
          navigationController?.pushViewController(view, animated: true)
      } else if UIDevice.current.userInterfaceIdiom == .pad {
          view.delegate = delegate
          navigationController?.present(view, animated: true)
      }
      
    }
    
    func goToModalGetInfo(_ task: Task, _ delegate: ModalGetInfoTaskViewDelegate, project: Project) {
        let view: ModalGetInfoTaskView = ModalGetInfoTaskView()
        let viewModel: ModalGetInfoTaskViewModel & Coordinating = ModalGetInfoTaskViewModel()
        view.delegate = delegate
        view.viewModel = viewModel
        viewModel.project = project
        viewModel.view = view
        viewModel.task = task
        viewModel.coordinator = self
        navigationController?.present(view, animated: true)
    }
    
    /// Initializes the coordinator and sets up the initial view and state.
    ///
    /// Call this method to start the coordinator and configure the initial state of the
    /// navigation controller. This method sets up the initial view and state of the app.
    func start() {
        let projectView: ProjectListView = ProjectListView()
        let projectViewModel: ProjectListViewModel & Coordinating = ProjectListViewModel()
        projectView.projectListViewModel = projectViewModel
        projectViewModel.coordinator = self
        projectViewModel.projectView = projectView

        // Set up the view controllers in the tab bar controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [projectView]

        // Store a reference to the tab bar controller for future reference
        self.tabBarController = tabBarController

        // Set the tab bar controller as the root view controller of the navigation controller
        navigationController?.setViewControllers([tabBarController], animated: false)
    }
}
