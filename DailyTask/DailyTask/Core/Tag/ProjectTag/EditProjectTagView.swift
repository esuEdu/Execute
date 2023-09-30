//
//  EditProjectTagView.swift
//  DailyTask
//
//  Created by Luca on 27/09/23.
//

import UIKit

class EditProjectTagView: UIViewController, UISheetPresentationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var viewModel: EditProjectTagViewModel?
    
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    private var sheetDetents: Double = 341
    
    var textField: UITextField!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        sheetPresentationController?.delegate = self
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.preferredCornerRadius = 10
        sheetPresentationController?.detents = [.custom(resolver: { context in
            return self.sheetDetents
        })]
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        
        let titleAndCloseButtonStackView = UIStackView()
        titleAndCloseButtonStackView.axis = .horizontal
        titleAndCloseButtonStackView.alignment = .center
        titleAndCloseButtonStackView.distribution = .equalSpacing
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = NSLocalizedString("Edit Tag", comment: "")
            label.font = .preferredFont(forTextStyle: .title3)
            label.isAccessibilityElement = true
            label.accessibilityLabel = NSLocalizedString("Task Tag Title", comment: "Accessibility Label for Task Tag Title")
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
        viewModel?.editTagProject(id: UUID(), name: textField.text ?? "", red: 0, green: 0, blue: 0)
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

