//
//  ChooseStepComponent.swift
//  DailyTask
//
//  Created by Eduardo on 06/10/23.
//

import Foundation
import UIKit


/// This is the protocol of `ChooseMethodologyComponent` that give you the hability to choose what will happen when the user choose the specific methodolgy
///
/// ## How to use?
///
/// It has only one function, `setUpMenuFunction(type: Methodologies)`. With that you receive the correct methodology and save whenever you want.
///
protocol ChooseStepComponentDelegate: AnyObject {
    func setUpMenuFunction(type: steps)
}

/// Component created to give the user the possibility to choose the main methodology of the project
///
/// ## How to use?
///
/// This structure has a `UIMenu` that gives you some options of the methodologies, CBL, Scrum and Custom
///
class ChooseStepComponent: UIView {
    
    weak var delegate: ChooseStepComponentDelegate?
    
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    private let steps = UILabel()
    
    private let viewToResizeTheButton: UIView = UIView()
    
    private let selectStep: UIButton = {
        let selectedMethodology = UIButton(primaryAction: nil)
        selectedMethodology.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        selectedMethodology.contentMode = .scaleAspectFit
        return selectedMethodology
    }()
    
    private let chooseStepBox: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = UIColor(.customTertiaryBlue)
        stackView.layer.cornerRadius = 10
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(font: UIFont = .boldTitle1, text: String, textColor: UIColor) {
        super.init(frame: .zero)
        steps.text = text
        steps.font = font
        steps.textColor = textColor
        
        selectStep.tintColor = textColor
        selectStep.titleLabel?.font = font
        addSubview(chooseStepBox)
        chooseStepBox.addArrangedSubview(steps)
        chooseStepBox.addArrangedSubview(selectStep)
        addAllConstraints()
        
        selectStep.menu = returnMenu()
        selectStep.showsMenuAsPrimaryAction = true
        selectionFeedbackGenerator.prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func returnMenu() -> UIMenu {
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
        
            UIAction(title: String(localized: "Engage"), handler: { _ in
            self.delegate?.setUpMenuFunction(type: .Engage)
                self.selectionFeedbackGenerator.selectionChanged()
        }),
        
            UIAction(title: String(localized: "Investigate"), handler: { _ in
            self.delegate?.setUpMenuFunction(type: .Investigate)
                self.selectionFeedbackGenerator.selectionChanged()
        }),
        
            UIAction(title: String(localized: "Act") , handler: { _ in
            self.delegate?.setUpMenuFunction(type: .Act)
                self.selectionFeedbackGenerator.selectionChanged()
        }),
        
        ])
        
        return menuItems
    }
    
    private func addAllConstraints() {
        NSLayoutConstraint.activate([
            chooseStepBox.leadingAnchor.constraint(equalTo: leadingAnchor),
            chooseStepBox.trailingAnchor.constraint(equalTo: trailingAnchor),
            chooseStepBox.topAnchor.constraint(equalTo: topAnchor),
            chooseStepBox.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // This give permission to change the methodology container change the label
    func changeTheStepText(_ text: String) {
        steps.text = text
        steps.layoutIfNeeded()
    }
}

/// Adding the methodologies of the project. You will create a enum case that support the especific methodology wanted. You have CBL, Scrum and Custom
enum steps: String {
    case Engage = "Engage"
    case Investigate = "Investigate"
    case Act = "Act"
    // Add more cases if nedeed
  
  func localized() -> String {
    return NSLocalizedString(self.rawValue, comment: "")
  }
  
}
