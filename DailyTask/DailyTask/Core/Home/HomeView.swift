//
//  HomeView.swift
//  DailyTask
//
//  Created by Eduardo on 22/09/23.
//

import UIKit

class HomeView: UIViewController {
    
    var homeViewModel: HomeViewModel?
    
    let segmentedControl = SegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
      
      let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("go to tasks view", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
      }()
        
        let tagComponent: TagComponent = {
            let tagComponent = TagComponent()
            tagComponent.button.setTitle("A", for: .normal)
            return tagComponent
        }()
        
        let tagComponent2: TagComponent = {
            let tagComponent = TagComponent()
            return tagComponent
        }()
        
        let tagComponent3: TagComponent = {
            let tagComponent = TagComponent()
            return tagComponent
        }()
        
        let tagComponent4: TagComponent = {
            let tagComponent = TagComponent()
            return tagComponent
        }()
        
        let tagComponent5: TagComponent = {
            let tagComponent = TagComponent()
            return tagComponent
        }()
        
        let tagComponent6: TagComponent = {
            let tagComponent = TagComponent()
            return tagComponent
        }()
        
        let tagComponent7: TagComponent = {
            let tagComponent = TagComponent()
            return tagComponent
        }()
        
        let tagsComponent: TagsColectionComponent = {
            let tagComponent = TagsColectionComponent(tags: [tagComponent, tagComponent2, tagComponent3, tagComponent4])
            return tagComponent
        }()
        
        //view.addSubview(tagsComponent)
     
        
        //tagsComponent.translatesAutoresizingMaskIntoConstraints = false
      
      view.addSubview(button)
      
      button.addTarget(self, action: #selector(goToTasks), for: .touchUpInside)
      
        NSLayoutConstraint.activate([
//            tagsComponent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            tagsComponent.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            tagsComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//            tagsComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),

            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        ])
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        print("Selected date: \(selectedDate)")
        // You can perform any action with the selected date here
    }
  
  @objc func goToTasks() {
    homeViewModel?.goToTasksView()
  }
  
}
