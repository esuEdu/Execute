//
//  MainCoordinator.swift
//  DailyTask
//
//  Created by Eduardo on 20/09/23.
//

import Foundation
import UIKit


// Define a class called MainCoordinator that conforms to the Coordinator protocol
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    // Implement the eventOccurred(with:) method from the Coordinator protocol
    func eventOccurred(with type: Event) {
        
        switch type {
            
            // Handle the case when a button is tapped
        case .buttonTapped:
            let vc: TableViewCellViewController & Coordinating = TableViewCellViewController()
            vc.coordinator = self
            let vm = TaskViewModel()
            vc.taskViewModel = vm
            vm.taskView = vc
            navigationController?.pushViewController(vc, animated: true)
        
        case .goToSubTaskList:
            let view: SubTaskTableView = SubTaskTableView()
            let viewModel: SubTaskListViewModel & Coordinating = SubTaskListViewModel()
            view.viewModel = viewModel
            viewModel.coordinator = self
            viewModel.view = view
            navigationController?.pushViewController(view, animated: true)
        }
        
    }
    
    // Implement the start() method from the Coordinator protocol
    func start() {
        let homeView: HomeView = HomeView()
        let homeViewModel: HomeViewModel & Coordinating = HomeViewModel()
        homeViewModel.coordinator = self
        homeView.homeViewModel = homeViewModel
        homeViewModel.homeView = homeView
        navigationController?.setViewControllers([homeView], animated: false)
    }
}
