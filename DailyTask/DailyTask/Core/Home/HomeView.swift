//
//  HomeView.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import UIKit

class HomeView: UIViewController {
    
    var homeViewModel: HomeViewModel?
    
    let teste = TaskContainerComponent()
    let teste4 = TaskContainerComponent()
    
    let teste2 = SubtaskComponent()
    let teste3 = SubtaskComponent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teste.translatesAutoresizingMaskIntoConstraints = false
        teste2.translatesAutoresizingMaskIntoConstraints = false
        teste3.translatesAutoresizingMaskIntoConstraints = false
        teste4.translatesAutoresizingMaskIntoConstraints = false
        teste4.line.isHidden = true
        teste3.secondLine.isHidden = true
        view.addSubview(teste)
        view.addSubview(teste2)
        view.addSubview(teste3)
        view.addSubview(teste4)
        addAllConstraints()
    }

    func addAllConstraints(){
        NSLayoutConstraint.activate([
            teste.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            teste.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            teste.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            teste.bottomAnchor.constraint(equalTo: teste2.topAnchor),
            
            teste2.topAnchor.constraint(equalTo: teste.bottomAnchor),
            teste2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            teste2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            teste2.bottomAnchor.constraint(equalTo: teste3.topAnchor),
            
            teste3.topAnchor.constraint(equalTo: teste2.bottomAnchor),
            teste3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            teste3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            teste3.bottomAnchor.constraint(equalTo: teste4.topAnchor, constant: -17),
            
            teste4.topAnchor.constraint(equalTo: teste3.bottomAnchor, constant: 17),
            teste4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            teste4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
    
}

#Preview{
    HomeView()
}
