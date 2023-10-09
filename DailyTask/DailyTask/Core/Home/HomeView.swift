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
//        let teste: DateAndCalendarComponent = {
//            let teste = DateAndCalendarComponent(date: "fadfaf")
//            teste.translatesAutoresizingMaskIntoConstraints = false
//            return teste
//        }()
        
        let allTaskListComponts: AllTaskListComponts = {
            let stackView = AllTaskListComponts(titleTask: "Joe Mama", timeLabel: "5:00")
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.clipsToBounds = true
            return stackView
        }()
        
//        view.addSubview(teste)
        view.addSubview(allTaskListComponts)
        
        NSLayoutConstraint.activate([
//            teste.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            teste.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            teste.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            allTaskListComponts.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            allTaskListComponts.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            allTaskListComponts.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            
            
        ])

    }

}


