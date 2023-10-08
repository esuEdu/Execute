//
//  ChooseMethodologyComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 28/09/23.
//

import UIKit

/// This is the protocol of `ChooseMethodologyComponent` that give you the hability to choose what will happen when the user choose the specific methodolgy
///
/// ## How to use?
///
/// It has only one function, `setUpMenuFunction(type: Methodologies)`. With that you receive the correct methodology and save whenever you want.
///
protocol ChooseMethodologyComponentDelegate: AnyObject{
    func setUpMenuFunction(type: Methodologies)
}

/// Component created to give the user the possibility to choose the main methodology of the project
///
/// ## How to use?
///
/// This structure has a `UIMenu` that gives you some options of the methodologies, CBL, Scrum and Custom
///
class ChooseMethodologyComponent: UIView{
    
    weak var delegate: ChooseMethodologyComponentDelegate?
    
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    var methodology = UILabel()
    
    private let viewToResizeTheButton: UIView = UIView()
    
    private let selectMethodology: UIButton = {
        let selectedMethodology = UIButton(primaryAction: nil)
        selectedMethodology.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        selectedMethodology.contentMode = .scaleAspectFit
        return selectedMethodology
    }()
    
    private let chooseMethodolyBox: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(font: UIFont, text: String, textColor: UIColor) {
        super.init(frame: .zero)
        methodology.text = text
        methodology.font = font
        methodology.textColor = textColor
        
        selectMethodology.tintColor = textColor
        selectMethodology.titleLabel?.font = font
        addSubview(chooseMethodolyBox)
        chooseMethodolyBox.addArrangedSubview(methodology)
        chooseMethodolyBox.addArrangedSubview(selectMethodology)
        addAllConstraints()
        
        selectMethodology.menu = returnMenu()
        selectMethodology.showsMenuAsPrimaryAction = true
        selectionFeedbackGenerator.prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
#warning("MUDAR A LAUNCHSCREEN")
    private func returnMenu() -> UIMenu{
        let menuItems = UIMenu(title: "", options: .displayInline, children: [

            UIAction(title: "Challenge Based Learning (CBL)", image: UIImage(systemName: "globe.americas.fill"), handler: { _ in
            self.delegate?.setUpMenuFunction(type: .CBL)
                self.selectionFeedbackGenerator.selectionChanged()
        }),
        
            UIAction(title: String(localized: "Scrum"), image: UIImage(systemName: "paperplane.fill"), handler: { _ in
            self.delegate?.setUpMenuFunction(type: .Scrum)
                self.selectionFeedbackGenerator.selectionChanged()
        }),
        
            UIAction(title: String(localized: "Custom"), image: UIImage(systemName: "pencil.tip.crop.circle.badge.plus") , handler: { _ in
            self.delegate?.setUpMenuFunction(type: .Custom)
                self.selectionFeedbackGenerator.selectionChanged()
        }),
        
        ])
        
        return menuItems
    }
    
    private func addAllConstraints(){
        NSLayoutConstraint.activate([
            chooseMethodolyBox.leadingAnchor.constraint(equalTo: leadingAnchor),
            chooseMethodolyBox.trailingAnchor.constraint(equalTo: trailingAnchor),
            chooseMethodolyBox.topAnchor.constraint(equalTo: topAnchor),
            chooseMethodolyBox.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // This give permission to change the methodology container change the label
    func changeTheMethodologyText(_ text: String){
        methodology.text = text
        methodology.layoutIfNeeded()
    }
    
    func hideButton(_ t: Bool){
        if t{
            selectMethodology.alpha = 0
        } else{
            selectMethodology.alpha = 1
        }
    }
}

/// Adding the methodologies of the project. You will create a enum case that support the especific methodology wanted. You have CBL, Scrum and Custom
enum Methodologies: String {
    case CBL = "CBL"
    case Scrum = "Scrum"
    case Custom = "Custom"
    // Add more cases if nedeed
}

#Preview{
    ChooseMethodologyComponent(font: .boldSystemFont(ofSize: 12), text: "MAMAMA", textColor: .red)
}
