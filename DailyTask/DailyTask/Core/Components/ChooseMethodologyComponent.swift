//
//  ChooseMethodologyComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 28/09/23.
//

import UIKit

protocol ChooseMethodologyComponentDelegate: AnyObject{
    func setUpMenuFunction(type: Methodologies)
}

class ChooseMethodologyComponent: UIView{
    
    weak var delegate: ChooseMethodologyComponentDelegate?
    
    let methodology: UILabel = {
        let methodology = UILabel()
        return methodology
    }()
    
    let viewToResizeTheButton: UIView = UIView()
    
    let selectMethodology: UIButton = {
        let selectedMethodology = UIButton(primaryAction: nil)
        selectedMethodology.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        selectedMethodology.contentMode = .scaleAspectFit
        return selectedMethodology
    }()
    
    let chooseMethodolyBox: UIStackView = {
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
//        selectMethodology.changesSelectionAsPrimaryAction = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func returnMenu() -> UIMenu{
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
        
            UIAction(title: "Challenge Based Learning (CBL)", image: UIImage(systemName: "globe.americas.fill"), handler: { _ in
            self.delegate?.setUpMenuFunction(type: .CBL)
        }),
        
            UIAction(title: String(localized: "Scrum"), image: UIImage(systemName: "paperplane.fill"), handler: { _ in
            self.delegate?.setUpMenuFunction(type: .Scrum)
        }),
        
            UIAction(title: String(localized: "Custom"), image: UIImage(systemName: "pencil.tip.crop.circle.badge.plus") , handler: { _ in
            self.delegate?.setUpMenuFunction(type: .Custom)
        }),
        
        ])
        
        return menuItems
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            chooseMethodolyBox.leadingAnchor.constraint(equalTo: leadingAnchor),
            chooseMethodolyBox.trailingAnchor.constraint(equalTo: trailingAnchor),
            chooseMethodolyBox.topAnchor.constraint(equalTo: topAnchor),
            chooseMethodolyBox.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
