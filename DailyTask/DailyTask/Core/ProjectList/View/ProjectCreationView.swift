//
//  ProjectCreationViewController.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import UIKit

class ProjectCreationView: UIViewController {
    
    var projectCreationViewModel: ProjectCreationViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItems = createGenericButtons()
        title = "Criar projeto"
    }

}

extension ProjectCreationView {
#warning("temporary")
    func createGenericButtons() -> [UIBarButtonItem]{
        let buttonToSupport: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.image = UIImage(systemName: "questionmark.circle")
            return button
        }()

        #warning("temporary")
        let buttonToConfiguration: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.image = UIImage(systemName: "gear")
            return button
        }()
        
        return [buttonToConfiguration, buttonToSupport]
    }

}
