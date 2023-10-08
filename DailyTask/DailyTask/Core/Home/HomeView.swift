//
//  HomeView.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import UIKit

class HomeView: UIViewController {
    
    var homeViewModel: HomeViewModel?
    var taskManager: TaskManager = TaskManager()
    
    var teste: StackTaskAndSubtaskComponent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let task = taskManager.fetchTask()
        
        teste = StackTaskAndSubtaskComponent(task: task.first!)
        print(task.first?.name)
        
        teste!.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(teste!)

        addAllConstraints()
    }

    func addAllConstraints(){
        NSLayoutConstraint.activate([
            teste!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            teste!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            teste!.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),


        ])
    }
    
}

#Preview{
    HomeView()
}
