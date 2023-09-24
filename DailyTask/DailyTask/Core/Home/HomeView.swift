//
//  HomeView.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import UIKit

class HomeView: UIViewController {

    var homeViewModel: HomeViewModel?
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        view.backgroundColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clique", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        view.addSubview(button)
        constraintsGo()
        
        button.addTarget(self, action: #selector(goToNextView), for: .touchUpInside)
    }
    
    @objc func goToNextView(){
        homeViewModel?.goToProjectList()
    }
    
    func constraintsGo(){
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }


}

#Preview {
    HomeView()
}
