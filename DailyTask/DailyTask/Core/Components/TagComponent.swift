//
//  TagComponent.swift
//  DailyTask
//
//  Created by Eduardo on 28/09/23.
//

import Foundation
import UIKit

class TagComponent: UIView {
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .borderedProminent()
        return button
    }()
    
    init(tagColor: UIColor = .gray, tagName: String = "Undefined") {
        super.init(frame: .zero)
        
        button.setTitle(tagName, for: .normal)
        button.tintColor = tagColor
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
