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
        title = "Home"
        view.backgroundColor = .systemBackground
        
        let textField: TextFieldToName = {
            let textField = TextFieldToName()
            return textField
        }()
        
        let textField2: TextFieldToName = {
            let textField = TextFieldToName()
            return textField
        }()
        
        let button: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.addTarget(self, action: #selector(goToSubTask), for: .touchUpInside)
            return button
        }()
        
        let container: ContainerComponent = {
            let container = ContainerComponent(text: "test",textColor: .label,button: button, components: [textField, textField2], spacing: 0)
            return container
        }()
        
        let datePicker: DatePickerComponent = {
            let datePicker = DatePickerComponent(datePickerStyle: .automatic, datePickerMode: .dateAndTime)
            return datePicker
        }()
                
        view.addSubview(container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
  
    @objc func goToSubTask() {
        print("test")
    }


}

#Preview {
    HomeView()
}
