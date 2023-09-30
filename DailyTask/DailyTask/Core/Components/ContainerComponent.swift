//
//  ContainerComponent.swift
//  DailyTask
//
//  Created by Eduardo on 27/09/23.
//

import UIKit


class ContainerComponent: UIView {
        
    let stackViewContainerTitle: UIStackView = {
        let stackViewContainerTitle = UIStackView()
        stackViewContainerTitle.axis = .horizontal
        stackViewContainerTitle.alignment = .center
        stackViewContainerTitle.distribution = .fill
        stackViewContainerTitle.backgroundColor = .systemGray2
        stackViewContainerTitle.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainerTitle.isLayoutMarginsRelativeArrangement = true
        stackViewContainerTitle.layoutMargins = UIEdgeInsets(top: 9, left: 15, bottom: 9, right: 15)
        return stackViewContainerTitle
    }()
    
    let containetTitle: LabelComponent = {
        let label = LabelComponent(text: "Default", accessibilityLabel: "", textColor: .label, font: .headline)
        return label
    }()
    
    let stackViewContainer: UIStackView = {
        let stackViewContainer = UIStackView()
        stackViewContainer.axis = .vertical
        stackViewContainer.alignment = .fill
        stackViewContainer.distribution = .fill
        stackViewContainer.backgroundColor = .systemGray5
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.isLayoutMarginsRelativeArrangement = true
        stackViewContainer.layoutMargins = UIEdgeInsets(top: 11, left: 15, bottom: 11, right: 15)
        return stackViewContainer
    }()
    
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return stackView
    }()
    
    init(text: String, textColor: UIColor = .label, button: UIButton? = nil, components: [UIView], spacing: CGFloat = 0 ) {
        super.init(frame: .zero)
        
        containetTitle.textLabel.text = text
        containetTitle.textLabel.textColor = textColor
        
        stackViewContainerTitle.addArrangedSubview(containetTitle)
        
        if let button = button {
            stackViewContainerTitle.addArrangedSubview(button)
        }else {
            containetTitle.stackView.alignment = .leading
        }
        
        for component in components {
            stackViewContainer.addArrangedSubview(component)
        }
        
        stackViewContainer.spacing = spacing
        
        stackView.addArrangedSubview(stackViewContainerTitle)
        stackView.addArrangedSubview(stackViewContainer)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackViewContainerTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewContainerTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
