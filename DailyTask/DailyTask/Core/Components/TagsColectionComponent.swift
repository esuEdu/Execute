//
//  TagsColectionComponent.swift
//  DailyTask
//
//  Created by Eduardo on 29/09/23.
//

import Foundation
import UIKit

class TagsColectionComponent: UIView {
    
    var innerStackView: UIStackView!
    
    let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(tags: [TagComponent], view: UIView) {
        super.init(frame: .zero)
        
        let maxWidth = view.frame.width - 70
        
        var currentLineStackView: UIStackView?
        
        var currentLineStackViewWidth: CGFloat = 0.0
        
        for tag in tags {
            let tagWidth = tag.frame.width
            
            
            if currentLineStackView == nil || (currentLineStackViewWidth + tagWidth) >=  maxWidth {
                currentLineStackView = createNewLineStackView()
                currentLineStackViewWidth = 0.0
            }
            currentLineStackView?.addArrangedSubview(tag)
            currentLineStackViewWidth += tagWidth + 6
        }

        
        addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            outerStackView.topAnchor.constraint(equalTo: topAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createNewLineStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.addArrangedSubview(stackView)
        
        return stackView
    }
}


