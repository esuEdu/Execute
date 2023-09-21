//
//  TableViewCellViewController.swift
//  DailyTask
//
//  Created by Eduardo on 20/09/23.
//

import UIKit

class TableViewCellViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SecondViewController"
        view.backgroundColor = .systemGreen
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

#Preview {
    TableViewCellViewController()
}
