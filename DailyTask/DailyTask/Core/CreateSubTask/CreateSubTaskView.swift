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
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16.5, left: 0, bottom: 0, right: 0)
        return stackView
    }()
    
    let label = LabelComponent(text: "SubTask", accessibilityLabel: "SubTask",font: .title3)

    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xbox.logo"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        return stackView
    }()
    
    let textField: TextFieldComponent = {
        let textField = TextFieldComponent()
        return textField
    }()
    
    let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray5
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 20)
        return stackView
    }()
    
    let dateLabel: LabelComponent = LabelComponent(text: "Date", accessibilityLabel: "Date")
    
    let datePicker: DatePickerComponent = {
        let datePicker = DatePickerComponent(datePickerMode: .time)
        
        return datePicker
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("done", for: .normal)
        button.configuration = .bordered()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        sheetPresentationController?.delegate = self
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.preferredCornerRadius = 10
        sheetPresentationController?.detents = [.custom(resolver: { context in
            return self.sheetDetents
        })]
        
        titleStackView.addArrangedSubview(label)
        
        stackView.addArrangedSubview(titleStackView)
        
        textFieldStackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(textFieldStackView)
        
        dateStackView.addArrangedSubview(dateLabel)
        
        datePicker.addTarget(self, action: #selector(dataChange), for: .valueChanged)
        dateStackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(dateStackView)
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        titleStackView.addArrangedSubview(closeButton)
        
        button.addTarget(self, action: #selector(saveAndClose), for: .touchUpInside)
        view.addSubview(button)
        
        view.addSubview(stackView)
        
        viewModel?.name = textField.textFieldToGetTheName.text
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveAndClose() {
        viewModel?.name = textField.getText() == "" ? "Sem título" : textField.getText()
        viewModel?.createSubTask()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dataChange(_ sender: UIDatePicker) {
        let date = sender.date
        viewModel?.startDate = date 
    }
}

#Preview{
    CreateSubTaskView()
}
