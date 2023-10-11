//
//  ContainerComponent.swift
//  DailyTask
//
//  Created by Eduardo on 27/09/23.
//

import UIKit

/// `ContainerComponent` is a custom UIView subclass that provides a container with a title, optional button, and a stack of components.
///
/// ## Example Usage
///
/// ```swift
/// let container = ContainerComponent(
///     text: "Container Title",
///     textColor: .label,
///     button: addButton, // Optional UIButton
///     components: [component1, component2],
///     spacing: 16
/// )
/// ```
///
/// - Note: You can add components to the container using `addNewElements(_:)` method and retrieve the position using `getPosition()` method.
class ContainerComponent: UIView {
    
    /// The stack view that contains the title and optional button.
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
    
    /// The title label.
    let containetTitle: LabelComponent = {
        let label = LabelComponent(text: "", accessibilityLabel: "", textColor: .label, font: .headline)
        return label
    }()
    
    /// The stack view that contains components.
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
    
    /// The main stack view that contains all elements.
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
    
    /// Initializes a new `ContainerComponent`.
    ///
    /// - Parameters:
    ///   - text: The title text.
    ///   - textColor: The text color for the title.
    ///   - button: An optional UIButton to be included in the title stack.
    ///   - components: An array of UIView components to be included in the container.
    ///   - spacing: The spacing between components in the stack view.
  init(text: String, textColor: UIColor = .label, acessibilityLabel: String , button: UIButton? = nil, components: [UIView], spacing: CGFloat = 0 ) {
        super.init(frame: .zero)
        
        containetTitle.textLabel.text = text
        containetTitle.textLabel.textColor = textColor
    containetTitle.textLabel.accessibilityLabel = acessibilityLabel
        
        stackViewContainerTitle.addArrangedSubview(containetTitle)
        
        if let button = button {
            stackViewContainerTitle.addArrangedSubview(button)
        } else {
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
    
    /// Adds a new UIView component to the container's stack.
    ///
    /// - Parameter view: The UIView component to add.
    func addNewElements(_ view: UIView){
        stackViewContainer.addArrangedSubview(view)
    }
    
    /// Returns the position of the component in the container's stack.
    ///
    /// - Returns: The position of the component.
    func getPosition() -> Int {
        return stackViewContainer.arrangedSubviews.count
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

