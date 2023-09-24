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
    
    func goToProjectList(){
        coordinator?.eventOccurred(with: .goToProjectList)
    }
    
}
