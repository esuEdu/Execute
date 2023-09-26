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
        case .goToProjectCreation:
            let view: ProjectCreationView  = ProjectCreationView()
            let viewModel: ProjectCreationViewModel & Coordinating = ProjectCreationViewModel()
            viewModel.coordinator = self
            viewModel.projectCreationView = view
            view.projectCreationViewModel = viewModel
            navigationController?.pushViewController(view, animated: true)
          
        case .goToProjectList:
            let projectListView: ProjectListView = ProjectListView()
            let projectListViewModel: ProjectListViewModel & Coordinating = ProjectListViewModel()
            projectListViewModel.coordinator = self
            projectListView.projectListViewModel = projectListViewModel
            projectListViewModel.projectView = projectListView
            navigationController?.pushViewController(projectListView, animated: true)
            
        case .goToSubTaskList:
            let view: SubTaskTableView = SubTaskTableView()
            let viewModel: SubTaskListViewModel & Coordinating = SubTaskListViewModel()
            view.viewModel = viewModel
            viewModel.coordinator = self
            viewModel.view = view
            navigationController?.pushViewController(view, animated: true)
          
        case .removeTopView:
            navigationController?.popViewController(animated: true)
            
        case .createModalView:
            let view: CreateSubTaskView = CreateSubTaskView()
            let viewModel = CreateSubTaskViewModel()
            view.viewModel = viewModel
            viewModel.coordinator = self
            viewModel.view = view
            navigationController?.present(view, animated: true)
          
        case .goToTaskView:
          let view: TaskView = TaskView()
          let viewModel: TaskViewModel & Coordinating = TaskViewModel()
          view.viewModel = viewModel
          viewModel.view = view
          viewModel.coordinator = self
          navigationController?.pushViewController(view, animated: true)
          
        case .goToCreateTaskView:
          let view: CreateTaskView = CreateTaskView()
          let viewModel: CreateTaskViewModel & Coordinating = CreateTaskViewModel()
          view.viewModel = viewModel
          viewModel.viewCreate = view
          viewModel.coordinator = self
          navigationController?.pushViewController(view, animated: true)
        
          
        }
        
    }
    
    /// Initializes the coordinator and sets up the initial view and state.
    ///
    /// Call this method to start the coordinator and configure the initial state of the
    /// navigation controller. This method sets up the initial view and state of the app.
    func start() {
        // Create instances of your view controllers
        let homeView: HomeView = HomeView()
        let homeViewModel: HomeViewModel & Coordinating = HomeViewModel()
        homeViewModel.coordinator = self
        homeView.homeViewModel = homeViewModel
        homeViewModel.homeView = homeView

        let projectView: ProjectListView = ProjectListView()
        let projectViewModel: ProjectListViewModel & Coordinating = ProjectListViewModel()
        projectView.projectListViewModel = projectViewModel
        projectViewModel.coordinator = self
        projectViewModel.projectView = projectView
        
        let taskView: TaskView = TaskView()
        let taskViewModel: TaskViewModel & Coordinating = TaskViewModel()
        taskViewModel.coordinator = self
        taskView.viewModel = taskViewModel
        taskViewModel.view = taskView

        let createSubTaskView: CreateSubTaskView = CreateSubTaskView()
        let createSubTaskViewModel = CreateSubTaskViewModel()
        createSubTaskView.viewModel = createSubTaskViewModel
        createSubTaskViewModel.coordinator = self
        createSubTaskViewModel.view = createSubTaskView

        // Create instances of UITabBarItem for each view controller
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: nil)
        let tableViewCellTabBarItem = UITabBarItem(title: "Table View", image: UIImage(named: "table_icon"), selectedImage: nil)
        let subTaskListTabBarItem = UITabBarItem(title: "Sub Tasks", image: UIImage(named: "subtasks_icon"), selectedImage: nil)
        let createSubTaskTabBarItem = UITabBarItem(title: "Create Sub Task", image: UIImage(named: "create_icon"), selectedImage: nil)

        // Assign tab bar items to the view controllers
        homeView.tabBarItem = homeTabBarItem
        projectView.tabBarItem = tableViewCellTabBarItem
        taskView.tabBarItem = subTaskListTabBarItem
        createSubTaskView.tabBarItem = createSubTaskTabBarItem

        // Set up the view controllers in the tab bar controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeView, projectView, taskView, createSubTaskView]

        // Store a reference to the tab bar controller for future reference
        self.tabBarController = tabBarController

        // Set the tab bar controller as the root view controller of the navigation controller
        navigationController?.setViewControllers([tabBarController], animated: false)
    }}
