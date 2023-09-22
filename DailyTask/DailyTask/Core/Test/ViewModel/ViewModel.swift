//
//  ViewModel.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import Foundation
import UIKit

class ViewModel: Coordinating {
    var coordinator: Coordinator?
    
    var view: ViewController?
    
    func path() {
        coordinator?.eventOccurred(with: .buttonTapped)
    }
}
