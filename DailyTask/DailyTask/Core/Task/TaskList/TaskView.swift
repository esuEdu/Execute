//
//  TaskView.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 24/09/23.
//

import Foundation
import UIKit

class TaskView: UIViewController {
    
    var viewModel: TaskViewModel?
  
  let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let calendar = Calendar.current
    
    let stackForTask: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.isLayoutMarginsRelativeArrangement = true
//        sv.layoutMargins = UIEdgeInsets.init(top: 31, left: 16, bottom: 0, right: 16)
        return sv
    }()
    
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
        return stackView
    }()
    
    let chooseStep = ChooseStepComponent(font: .preferredFont(forTextStyle: .body), text: String(localized: "Engage"), textColor: UIColor(.customButtonMenu) ?? .label)
    
    let newTask = {
       let newTask = UIButton()
      newTask.configuration = .borderless()
      newTask.configuration?.image = UIImage(systemName: "plus")
      newTask.configuration?.title = String(localized: "NewTaskKey")
      newTask.configuration?.imagePadding = 6
      return newTask
    }()
    
    var dateAndCalendarComponent: DateAndCalendarComponent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = UIColor(.customBackground)
      
      selectionFeedbackGenerator.prepare()
        
        datePicker.minimumDate = viewModel?.project?.start
        datePicker.maximumDate = viewModel?.project?.end
        
        title = viewModel?.project?.name
        
        dateAndCalendarComponent = DateAndCalendarComponent(date: formatter.string(from: viewModel!.date))
        
        chooseStep.delegate = self
        mainStack.addArrangedSubview(dateAndCalendarComponent!)
        
        if viewModel?.project?.methodology == "CBL" {
            secondaryStack.addArrangedSubview(chooseStep)
        }else {
            secondaryStack.alignment = .trailing
        }
                
        secondaryStack.addArrangedSubview(newTask)
        
        mainStack.addArrangedSubview(secondaryStack)
        view.addSubview(mainStack)
        view.addSubview(scrollView)
        scrollView.addSubview(stackForTask)
        
        datePicker.addTarget(self, action: #selector(date), for: .valueChanged)
        newTask.addTarget(self, action: #selector(createTask), for: .touchUpInside)
        
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: dateAndCalendarComponent!.button.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: dateAndCalendarComponent!.button.centerYAnchor),
            datePicker.widthAnchor.constraint(equalTo: dateAndCalendarComponent!.widthAnchor,multiplier: 0.1),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            mainStack.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: -25),
            scrollView.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 25),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackForTask.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackForTask.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackForTask.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackForTask.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackForTask.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        getTasksAndSubtasks()
        
    }
    
    func getTasksAndSubtasks(){
        
        for task in stackForTask.arrangedSubviews{
            task.removeFromSuperview()
        }

        viewModel?.fetchTasks()
        if let tasks = viewModel?.task{
            for task in tasks{
                let taskComponent = StackTaskAndSubtaskComponent(task: task)
                taskComponent.delegate = self
                stackForTask.addArrangedSubview(taskComponent)
                if let taskStart = taskComponent.task?.start,
                   let taskEnd = taskComponent.task?.end{
                    let comparisonResult = calendar.compare(taskStart, to: viewModel!.date, toGranularity: .day)
                    let comparisonResult2 = calendar.compare(taskEnd, to: viewModel!.date, toGranularity: .day)
                    
                    if ((comparisonResult == .orderedSame && comparisonResult2 == .orderedDescending) || (comparisonResult == .orderedSame && comparisonResult2 == .orderedSame) || (comparisonResult == .orderedAscending && comparisonResult2 == .orderedDescending)) && (taskComponent.task?.step == viewModel?.step.rawValue){
                        taskComponent.isHidden = false
                    } else{
                        taskComponent.isHidden = true
                    }
                    
                }
                   
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getTasksAndSubtasks()
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func date(_ sender: UIDatePicker) {
        let date = sender.date
        viewModel?.date = date
        dateAndCalendarComponent?.dateLabel?.textLabel.text = formatter.string(from: viewModel!.date)
        
        reloadStack()
    }
    
    func reloadStack(){
        for task in stackForTask.arrangedSubviews{
            let taskComponent = task as? StackTaskAndSubtaskComponent
            if let taskStart = taskComponent?.task?.start,
               let taskEnd = taskComponent?.task?.end{
                let comparisonResult = calendar.compare(taskStart, to: viewModel!.date, toGranularity: .day)
                let comparisonResult2 = calendar.compare(taskEnd, to: viewModel!.date, toGranularity: .day)
                
                if ((comparisonResult == .orderedSame && comparisonResult2 == .orderedDescending) || (comparisonResult == .orderedSame && comparisonResult2 == .orderedSame) || (comparisonResult == .orderedAscending && comparisonResult2 == .orderedDescending)) && (taskComponent?.task?.step == viewModel?.step.rawValue){
                    taskComponent!.isHidden = false
                    
                } else{
                    taskComponent!.isHidden = true
                    
                }
            }
        }
    }
    
    @objc func createTask() {
        viewModel?.goToCreateTasks()
    }
    
}

extension TaskView: ModalGetInfoTaskViewDelegate, StackTaskAndSubtaskComponentDelegate {
    func wasItChecked(_ task: Task) {
        viewModel?.concludedTask(task)
    }
    
    func deleted(_ task: Task) {
        viewModel?.fetchTasks()
        
        for n in stackForTask.arrangedSubviews{
            if let r = n as? StackTaskAndSubtaskComponent{
                if r.task == task{
                    r.removeFromSuperview()
                    stackForTask.layoutSubviews()
                }
            }
        }
    }
    
    func itWasPressed(_ task: Task) {
      selectionFeedbackGenerator.selectionChanged()
        viewModel?.goToModalGetInfo(task, delegate: self)
    }
    
    func changeHappened(_ task: Task) {
        viewModel?.concludeSubtask(task: task)
        getTasksAndSubtasks()
    }
}

extension TaskView: ChooseStepComponentDelegate {
    
    func setUpMenuFunction(type: steps) {
        self.viewModel?.selectedStep(type)
      self.chooseStep.changeTheStepText(String(describing: self.viewModel!.step.localized()))
        self.reloadStack()
    }
    
}
