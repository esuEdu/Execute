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

        // Do any additional setup after loading the view.
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
        view.addSubview(button)
        button.center = view.center
        button.backgroundColor = UIColor(.customBlue)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitle("Tap Me!", for: .normal)

        let datePickerController = DatePickerView<Date>(frame: CGRect(x: 90, y: 200, width: 0, height: 0))
        datePickerController.datePickerMode = .date
        datePickerController.backgroundColor = .green
        datePickerController.valueChangedHandler = { selectedDate in
            print("Selected Time: \(selectedDate)")
        }
        view.addSubview(datePickerController)
    }
    
    @objc func didTapButton() {
        homeViewModel?.coordinator?.eventOccurred(with: .createModalView)
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
