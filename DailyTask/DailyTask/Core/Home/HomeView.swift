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
  
  let segmentedControl = SegmentedControl(items: ["5 min", "15 min"])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        view.backgroundColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clique", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(goToNextView), for: .touchUpInside)
        view.addSubview(button)
        
        

      view.addSubview(segmentedControl)
      segmentedControl.translatesAutoresizingMaskIntoConstraints = false
      

        let datePickerController = DatePickerView<Date>(frame: CGRect(x: 90, y: 500, width: 0, height: 0))
        datePickerController.datePickerMode = .dateAndTime
        datePickerController.backgroundColor = .green
        datePickerController.valueChangedHandler = { selectedDate in
            print("Selected Time: \(selectedDate)")
        }
        view.addSubview(datePickerController)
      
      let taskButton = UIButton()
      view.addSubview(taskButton)
        
      taskButton.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        taskButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
        taskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
        taskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
      ])
      taskButton.backgroundColor = UIColor(.customRed)
      taskButton.setTitleColor(.white, for: .normal)
      taskButton.setTitle("Go to tasks", for: .normal)
      taskButton.addTarget(self, action: #selector(goToTasks), for: .touchUpInside)
      
      constraintsGo()
      
    }
    
    @objc func goToNextView(){
        homeViewModel?.goToProjectList()
    }
    
    func constraintsGo(){
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: button.bottomAnchor),
            
            
        ])
    }
  
    @objc func goToSubTask() {
        
    }
  
  @objc func goToTasks() {
    homeViewModel?.goToTasksView()
  }


}

#Preview {
    HomeView()
}
