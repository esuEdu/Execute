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
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var cont: Int = 0
    
    init(tags: [TagComponent]) {
        super.init(frame: .zero)
        
        let maxWidth = self.frame.width // Largura máxima do componente
   
        
        var currentLineStackView: UIStackView?
        
        var currentLineStackViewWidth: CGFloat = 0.0
        
        for tag in tags {
            let tagWidth = tag.frame.width
    
            // Verifique se há espaço suficiente na linha atual para a próxima tag
            
            if currentLineStackView == nil || (currentLineStackViewWidth + tagWidth) > maxWidth {
                currentLineStackView = createNewLineStackView()
                print(tagWidth)
                currentLineStackViewWidth = 0.0
            }
            
            currentLineStackView?.addArrangedSubview(tag)
            currentLineStackViewWidth += tagWidth
            
            
        }
        
        outerStackView.addArrangedSubview(innerStackView)
        
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
        
        if innerStackView == nil {
            innerStackView = stackView
        } else {
            outerStackView.addArrangedSubview(stackView)
        }
        
        return stackView
    }
}
