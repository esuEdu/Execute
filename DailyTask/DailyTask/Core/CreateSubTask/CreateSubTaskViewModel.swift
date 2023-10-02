//
//  CreateSubTaskViewModel.swift
//  DailyTask
//
//  Created by Eduardo on 25/09/23.
//

import Foundation

protocol CreateSubTaskViewModelDelegate: AnyObject{
    func createSubview(name: String, startDate: Date)
}

class CreateSubTaskViewModel: Coordinating {
    
    weak var delegate: CreateSubTaskViewModelDelegate?
    var coordinator: Coordinator?
    var view: CreateSubTaskView?
    
    var name: String?
    var startDate: Date?
    
    init(){
        self.name = "Sem título"
        self.startDate = Date.now
    }
    
    func createSubTask() {
        delegate?.createSubview(name: name!, startDate: startDate!)
    }
    
}


