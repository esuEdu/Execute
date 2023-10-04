//
//  MainTabBarController.swift
//  DailyTask
//
//  Created by Eduardo on 04/10/23.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    let main = MainCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        main.start()
        viewControllers = [main.navigationController]

    }
}
