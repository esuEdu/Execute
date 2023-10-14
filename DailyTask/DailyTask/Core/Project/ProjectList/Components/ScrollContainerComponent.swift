//
//  ScrollContainerComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 04/10/23.
//

import UIKit

class ScrollContainerComponent: UIScrollView {

    let stackViewToShowElements: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        sv.isLayoutMarginsRelativeArrangement = true
        if UIDevice.current.userInterfaceIdiom == .phone {
            sv.layoutMargins = UIEdgeInsets(top: 15, left: 25, bottom: 10, right: 25)
            sv.spacing = 25
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            sv.layoutMargins = UIEdgeInsets(top: 40, left: 100, bottom: 35, right: 100)
            sv.spacing = 45
        }
        
        return sv
    }()
    
    init(views: [ContainerProjectsList] = []){
        super.init(frame: .zero)
        self.showsVerticalScrollIndicator = false
        
        addSubview(stackViewToShowElements)
        addAllContraints()
        
        for sub in views{
            stackViewToShowElements.addArrangedSubview(sub)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func contains(_ string: String){
        let text = string.uppercased()
        
        for n in stackViewToShowElements.arrangedSubviews{
            n.isHidden = false
            layoutIfNeeded()
        }
        
        if string != ""{
            for n in stackViewToShowElements.arrangedSubviews{
                let r = n as! ContainerProjectsList
                let upperCasedTitle = r.projectTitle.textLabel.text?.uppercased()
                let upperCasedDescription = r.projectDesc.textLabel.text?.uppercased()
                if upperCasedTitle!.contains(text) || upperCasedDescription!.contains(text){
                } else{
                    UIView.animate(withDuration: 0.5) {
                    }
                    n.isHidden = true
                    layoutIfNeeded()
                }
            }
            layoutIfNeeded()
        }
    }
    
    func addNewElements(_ view: UIView){
        stackViewToShowElements.addArrangedSubview(view)
    }
    
    func removeAllElements(){
        for element in stackViewToShowElements.arrangedSubviews{
            stackViewToShowElements.removeArrangedSubview(element)
            element.removeFromSuperview()
        }
    }
    
    func getPosition() -> Int{
        return stackViewToShowElements.arrangedSubviews.count
    }
    
    func addAllContraints(){
        NSLayoutConstraint.activate([
            stackViewToShowElements.topAnchor.constraint(equalTo: topAnchor),
            stackViewToShowElements.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackViewToShowElements.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewToShowElements.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewToShowElements.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
}
