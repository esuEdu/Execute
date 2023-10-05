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
        let teste: ProjectTitleComponent = {
            let teste = ProjectTitleComponent(projectTitle: "teste", color: .blue)
            teste.translatesAutoresizingMaskIntoConstraints = false
            return teste
        }()
        
        view.addSubview(teste)
        
        NSLayoutConstraint.activate([
            teste.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            teste.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            teste.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }
    
    
    
}

