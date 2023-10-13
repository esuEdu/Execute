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
        
        let showModalButton = UIButton(type: .system)
                showModalButton.setTitle("Show Modal", for: .normal)
                showModalButton.addTarget(self, action: #selector(showModalButtonTapped), for: .touchUpInside)
                showModalButton.translatesAutoresizingMaskIntoConstraints = false
        
        let imageOneView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "lightbulb.fill"))
            imageView.tintColor = .red
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
//        view.addSubview(teste)
        view.addSubview(allTaskListComponts)
        view.addSubview(showModalButton)
        view.addSubview(imageOneView)
        
        NSLayoutConstraint.activate([
//            teste.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            teste.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            teste.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
//            allTaskListComponts.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            allTaskListComponts.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            allTaskListComponts.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            showModalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showModalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageOneView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageOneView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
        ])

    }

    @IBAction func showModalButtonTapped(_ sender: UIButton) {
        let modalVC = PickIconModalViewController()
        modalVC.modalPresentationStyle = .formSheet // Customize the presentation style if needed
        present(modalVC, animated: true, completion: nil)
    }
}


