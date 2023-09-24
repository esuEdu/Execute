//
//  TableViewCellViewController.swift
//  DailyTask
//
//  Created by Eduardo on 20/09/23.
//

import UIKit

class TableViewCellViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    var taskViewModel: TaskViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
        view.addSubview(button)
        button.center = view.center
        button.backgroundColor = UIColor(.customBlue)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitle("Tap Me!", for: .normal)
        isEditing = false
    }
    
    @objc func didTapButton() {
        taskViewModel?.edit()
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
