//
//  HomeView.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import UIKit

class HomeView: UIViewController {
    
    var homeViewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Create a custom button
        let teste: TaskContainerComponent = {
            let teste = TaskContainerComponent()
            teste.translatesAutoresizingMaskIntoConstraints = false
            
            return teste
        }()
        
        view.addSubview(teste)
        
        NSLayoutConstraint.activate([
            teste.widthAnchor.constraint(equalToConstant: 260),
            teste.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            teste.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
}

