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
    var navigationController: UINavigationController
    
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
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
            let view: ProjectCreationView = ProjectCreationView()
            let viewModel: ProjectCreationViewModel & Coordinating = ProjectCreationViewModel()
            viewModel.coordinator = self
            viewModel.projectCreationView = view
            view.projectCreationViewModel = viewModel
            if UIDevice.current.userInterfaceIdiom == .pad{
                navigationController.present(view, animated: true)
            }else{
                navigationController.pushViewController(view, animated: true)
            }
            
        case .goToProjectList:
            let projectListView: ProjectListView = ProjectListView()
            let projectListViewModel: ProjectListViewModel & Coordinating = ProjectListViewModel()
            projectListViewModel.coordinator = self
            projectListView.projectListViewModel = projectListViewModel
            projectListViewModel.projectView = projectListView
            navigationController.pushViewController(projectListView, animated: true)
            
        case .removeTopView:
            navigationController.popViewController(animated: true)
            
            
        case .createModalView:
            let view: CreateSubTaskView = CreateSubTaskView()
            let viewModel = CreateSubTaskViewModel()
            view.viewModel = viewModel
            viewModel.coordinator = self
            viewModel.view = view
            navigationController.present(view, animated: true)
            
            
        case .goToTaskTagView:
            let view: TaskTagView = TaskTagView()
            let viewModel: TaskTagViewModel & Coordinating = TaskTagViewModel()
            view.viewModel = viewModel
            viewModel.view = view
            viewModel.coordinator = self
            navigationController.pushViewController(view, animated: true)
            
        case .goToProjectTagView:
            let view: ProjectTagView = ProjectTagView()
            let viewModel: ProjectTagViewModel & Coordinating = ProjectTagViewModel()
            view.viewModel = viewModel
            viewModel.view = view
            viewModel.coordinator = self
            navigationController.pushViewController(view, animated: true)
            
        }
        
    }
    
    func goToTaskView(_ project: Project){
        let view: TaskView = TaskView()
        let viewModel: TaskViewModel & Coordinating = TaskViewModel(project: project)
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.coordinator = self
        navigationController.pushViewController(view, animated: true)
    }
    
    func goToTaskCreation(_ project: Project){
        let view: CreateTaskView = CreateTaskView()
        let viewModel: CreateTaskViewModel & Coordinating = CreateTaskViewModel()
        viewModel.project = project
        view.viewModel = viewModel
        viewModel.viewCreate = view
        viewModel.coordinator = self
        navigationController.pushViewController(view, animated: true)
    }
    
    func goToModalGetInfo(_ task: Task, _ delegate: ModalGetInfoTaskViewDelegate) {
        let view: ModalGetInfoTaskView = ModalGetInfoTaskView()
        let viewModel: ModalGetInfoTaskViewModel & Coordinating = ModalGetInfoTaskViewModel()
        view.delegate = delegate
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.task = task
        viewModel.coordinator = self
        navigationController.present(view, animated: true)
    }
    
    /// Initializes the coordinator and sets up the initial view and state.
    ///
    /// Call this method to start the coordinator and configure the initial state of the
    /// navigation controller. This method sets up the initial view and state of the app.
    func start() {
        // Create instances of your view controllers
//        let homeView = TESTViewController()
        let homeView = HomeView()
        let homeViewModel: HomeViewModel & Coordinating = HomeViewModel()
        homeViewModel.coordinator = self
        homeView.homeViewModel = homeViewModel
        homeViewModel.homeView = homeView

        homeView.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        
        let projectView: ProjectListView = ProjectListView()
        let projectViewModel: ProjectListViewModel & Coordinating = ProjectListViewModel()
        projectView.projectListViewModel = projectViewModel
        projectViewModel.coordinator = self
        projectViewModel.projectView = projectView
    
        projectView.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        navigationController.setViewControllers([homeView], animated: false)
        // Set the tab bar controller as the root view controller
        // This will display the tab bar with the first tab (HomeView) selected

    }
}

