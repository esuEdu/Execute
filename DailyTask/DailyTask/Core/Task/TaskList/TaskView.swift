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
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.alpha = 0.011
        picker.isOpaque = true
        picker.isHidden = false
        return picker
    }()
     
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
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let secondaryStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 64
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        return stackView
    }()
    
    let chooseStep = ChooseStepComponent(font: .preferredFont(forTextStyle: .body), text: "Steps", textColor: UIColor.accent)
    
    let newTask = {
       let newTask = UIButton()
        newTask.setImage(UIImage(systemName: "plus"), for: .normal)
        newTask.setTitle("New Task", for: .normal)
        newTask.setTitleColor(.accent, for: .normal)
        return newTask
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .systemBackground
        
        title = viewModel?.project?.name
        
        let dateAndCalendarComponent = DateAndCalendarComponent(date: formatter.string(from: Date.now))
        
        chooseStep.delegate = self
        mainStack.addArrangedSubview(dateAndCalendarComponent)
        
        if viewModel?.project?.methodology == "CBL" {
            secondaryStack.addArrangedSubview(chooseStep)
        }else {
            secondaryStack.alignment = .trailing
        }
                
        secondaryStack.addArrangedSubview(newTask)
        
        mainStack.addArrangedSubview(secondaryStack)
        view.addSubview(mainStack)
        
        datePicker.addTarget(self, action: #selector(date), for: .valueChanged)
        newTask.addTarget(self, action: #selector(createTask), for: .touchUpInside)
        
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: dateAndCalendarComponent.button.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: dateAndCalendarComponent.button.centerYAnchor),
            datePicker.widthAnchor.constraint(equalTo: dateAndCalendarComponent.widthAnchor,multiplier: 0.1),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @objc func date(_ sender: UIDatePicker) {
        let date = sender.date
        print(date)
        viewModel?.date = date
    }
    
    @objc func createTask() {
        viewModel?.goToCreateTasks()
    }
    
}

extension TaskView: ModalGetInfoTaskViewDelegate {
    func changeHappened() {
        viewModel?.fetchTasks()
    }
}

extension TaskView: ChooseStepComponentDelegate {
    
    func setUpMenuFunction(type: steps) {
        self.viewModel?.selectedStep(type)
        self.chooseStep.changeTheStepText(String(describing: self.viewModel!.step!.rawValue))
    }
}
