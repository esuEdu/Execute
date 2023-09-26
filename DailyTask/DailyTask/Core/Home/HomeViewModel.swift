//
//  HomeViewModel.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import Foundation

class HomeViewModel: Coordinating {
    
    var coordinator: Coordinator?
    var homeView: HomeView?
  
  
  
  
  
  
  
  
  func goToTasksView() {
    coordinator?.eventOccurred(with: .goToTaskView)
  }
    
    func goToProjectList(){
        coordinator?.eventOccurred(with: .goToProjectList)
    }
    
}
