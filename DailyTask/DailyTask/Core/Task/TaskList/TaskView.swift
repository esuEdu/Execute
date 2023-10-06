//
//  TaskView.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 24/09/23.
//

import Foundation
import UIKit

class TaskView: UIViewController{
    
    var viewModel: TaskViewModel?
    
    var formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .systemBackground
        
        title = viewModel?.project?.name
    
        let dateAndCalendarComponent = DateAndCalendarComponent(date: formatter.string(from: Date.now))
        dateAndCalendarComponent.button.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)
        mainStack.addArrangedSubview(dateAndCalendarComponent)
        
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @objc func openCalendar() {
        // Open the default calendar app
        if let calendarURL = URL(string: "calshow://") {
            UIApplication.shared.open(calendarURL, options: [:], completionHandler: nil)
        }
    }
    
}

extension TaskView: ModalGetInfoTaskViewDelegate {
    func changeHappened() {
        viewModel?.fetchTasks()
    }
}
