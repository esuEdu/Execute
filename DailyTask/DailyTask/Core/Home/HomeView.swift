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
        let teste = TopProjectColapsedAndExpandedView()
        teste.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(teste)
        teste.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teste.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        teste.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        teste.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
    }


}

#Preview {
    HomeView()
}
