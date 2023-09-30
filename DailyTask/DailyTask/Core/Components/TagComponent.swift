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
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
//        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(tagColor: UIColor = .gray, tagName: String = "Undefined") {
        super.init(frame: .init(x: 0, y: 0, width: 115, height: 0))
        
        label.text = tagName
        
        button.addSubview(label)
        button.tintColor = tagColor
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.topAnchor.constraint(equalTo: button.topAnchor),
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: button.bottomAnchor),
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
