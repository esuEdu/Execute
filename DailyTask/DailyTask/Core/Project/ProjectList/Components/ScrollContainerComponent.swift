//
//  ScrollContainerComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 04/10/23.
//

import UIKit

class ScrollContainerComponent: UIScrollView {

    private let stackViewToShowElements: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 25
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
        if string != ""{
            for n in stackViewToShowElements.arrangedSubviews{
                let r = n as! ContainerProjectsList
                let upperCasedTitle = r.projectTitle.textLabel.text?.uppercased()
                let upperCasedDescription = r.projectDesc.textLabel.text?.uppercased()
                if upperCasedTitle!.contains(text) || upperCasedDescription!.contains(text){
                    
                    n.isHidden = false
                } else{
                    UIView.animate(withDuration: 0.5, animations: {
                        n.alpha = 0
                    }) { (completed) in
                        n.isHidden = true
                    }
                    n.isHidden = true
                }
            }
            layoutIfNeeded()
        }
    }
    
    func addNewElements(_ view: UIView){
        stackViewToShowElements.addArrangedSubview(view)
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
