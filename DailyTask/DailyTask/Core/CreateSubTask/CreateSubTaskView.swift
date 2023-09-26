//
//  CreateSubTaskView.swift
//  DailyTask
//
//  Created by Eduardo on 25/09/23.
//

import UIKit


class CreateSubTaskView: UIViewController, UISheetPresentationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var viewModel: CreateSubTaskViewModel?
    
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    private var sheetDetents: Double = 276
    
    var textField: UITextField!
    var startDate: Date?
    var endDate: Date?
    
    
    
    override func loadView() {
        super.loadView()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        
        view.backgroundColor = .systemBackground
        sheetPresentationController?.delegate = self
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.preferredCornerRadius = 10
        sheetPresentationController?.detents = [.custom(resolver: { context in
            return stackView.frame.height
        })]
        
    
        
        let titleAndCloseButtonStackView = UIStackView()
        titleAndCloseButtonStackView.axis = .horizontal
        titleAndCloseButtonStackView.alignment = .center
        titleAndCloseButtonStackView.distribution = .equalSpacing
        
        let titleAndTimeStackView = UIStackView()
        titleAndTimeStackView.axis = .horizontal
        titleAndTimeStackView.alignment = .center
        titleAndTimeStackView.distribution = .equalSpacing
        
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = NSLocalizedString("Sub-Task", comment: "")
            label.font = .preferredFont(forTextStyle: .title3)
            label.isAccessibilityElement = true
            label.accessibilityLabel = NSLocalizedString("Sub-Task Title", comment: "Accessibility Label for Sub-Task Title")
            return label
        }()
        
        titleAndCloseButtonStackView.addArrangedSubview(titleLabel)
        
        // Create a UIButton for closing the modal
        let closeButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "logo.xbox"), for: .normal)
            button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
            return button
        }()
        
        titleAndCloseButtonStackView.addArrangedSubview(closeButton)
        
        stackView.addArrangedSubview(titleAndCloseButtonStackView)
        
        
        
        textField = UITextField()
        textField.placeholder = "Enter text"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self // Set the delegate to capture events
        
        // Add the UITextField to the view
        view.addSubview(textField)
        stackView.addArrangedSubview(textField)
        
        
        let titleDate: UILabel = {
            let label = UILabel()
            label.text = NSLocalizedString("Date:", comment: "")
            label.font = .preferredFont(forTextStyle: .title3)
            label.isAccessibilityElement = true
            label.accessibilityLabel = NSLocalizedString("Sub-Task Title", comment: "Accessibility Label for Sub-Task Title")
            return label
        }()
        
        titleAndTimeStackView.addArrangedSubview(titleDate)
        
        let datePicker: DatePickerView<Date> = {
            let datePicker = DatePickerView<Date>()
            datePicker.datePickerMode = .time
            datePicker.valueChangedHandler = { selectedDate in
                self.endDate = selectedDate
            }
            return datePicker
        }()
        titleAndTimeStackView.addArrangedSubview(datePicker)
        
        stackView.addArrangedSubview(titleAndTimeStackView)
        
        let saveButton: UIButton = {
            let saveButton = UIButton(type: .roundedRect)
            saveButton.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)
            saveButton.addTarget(self, action: #selector(saveAndClose), for: .touchUpInside)
            return saveButton
        }()
        
        stackView.addArrangedSubview(saveButton)
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveAndClose() {
        viewModel?.createSubTask(name: textField.text ?? "", startDate: Date.now, endDate: endDate ?? Date.now)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            // Use the 'text' variable to access the typed data
            print("Typed Text: \(text)")
            
            // You can perform further actions with the retrieved text here
        }
    }
}

#Preview{
    CreateSubTaskView()
}
