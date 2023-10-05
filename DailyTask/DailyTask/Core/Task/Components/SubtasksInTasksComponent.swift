//
//  SubtasksInTasksComponent.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 29/09/23.
//

import Foundation
import UIKit

class SubtasksInTasksComponent: UIView {
    
    let checkbox = Checkbox()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 10)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let labelSubTasks: BreakableTextComponent = {
        let label = BreakableTextComponent(placeholderColor: .systemGray2, textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    init(name: String) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.addSubview(stackView)
                
        stackView.addArrangedSubview(checkbox)
        stackView.addArrangedSubview(labelSubTasks)
        stackView.addArrangedSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            checkbox.heightAnchor.constraint(equalToConstant: 30),
            checkbox.widthAnchor.constraint(equalToConstant: 29),
        ])
        
    }
    
    func returnText() -> String{
        return labelSubTasks.getText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



#Preview{
    SubtasksInTasksComponent(name: "Bom dia")
}
