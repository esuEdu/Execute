//
//  ContainerProjectsList.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 02/10/23.
//

import Foundation
import UIKit

/// A custom container view for displaying project information.
///
/// `ContainerProjectsList` is a UIView subclass designed to display project details,
/// including the project title, description, completion percentage, and an icon.
///
/// ## Usage
///
/// To use `ContainerProjectsList`, create an instance and provide the project's title,
/// description, completion percentage, and optional customization parameters for icons
/// and colors. The view will automatically arrange and display the provided information.
///
/// ```swift
/// let projectContainer = ContainerProjectsList(
///     title: "Project X",
///     description: "A sample project description goes here.",
///     percentage: "75",
///     imageIcon: UIImage(systemName: "ellipsis.message.fill")!,
///     imageIconColor: .white,
///     chevronColor: .white
/// )
/// ```
///
/// - Note: `ContainerProjectsList` is suitable for displaying project details in a visually
///         appealing and organized manner.
///
/// - Important: Ensure you provide the necessary project information and customize the
///              appearance as needed.
class ContainerProjectsList: UIView {
    
    /// The horizontal stack view for the project title, icon, and chevron.
    let stackViewContainerTitle: UIStackView = {
        let stackViewContainerTitle = UIStackView()
        stackViewContainerTitle.axis = .horizontal
        stackViewContainerTitle.alignment = .center
        stackViewContainerTitle.distribution = .fill
        stackViewContainerTitle.backgroundColor = .systemGreen
        stackViewContainerTitle.spacing = 12
        stackViewContainerTitle.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainerTitle.isLayoutMarginsRelativeArrangement = true
        stackViewContainerTitle.layoutMargins = UIEdgeInsets(top: 9, left: 12, bottom: 9, right: 15)
        return stackViewContainerTitle
    }()
    
    /// The label component for the project title.
    let projectTitle = LabelComponent(text: "Default", accessibilityLabel: "", textColor: .black, font: .headline, numberOfLines: 2, lineBreakMode: .byTruncatingTail)
     
    /// The image view for the project icon.
    let iconTitle = UIImageView()
    
    /// The image view for the chevron icon.
    let chevron: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        return image
    }()
    
    /// The horizontal stack view for the project description and completion percentage.
    let stackViewContainer: UIStackView = {
        let stackViewContainer = UIStackView()
        stackViewContainer.axis = .horizontal
      stackViewContainer.alignment = .center
      stackViewContainer.distribution = .fill
        stackViewContainer.backgroundColor = .systemGray3
        stackViewContainer.spacing = 25
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.isLayoutMarginsRelativeArrangement = true
        stackViewContainer.layoutMargins = UIEdgeInsets(top: 17.5, left: 15, bottom: 17.5, right: 15)
        return stackViewContainer
    }()
    
    /// The label component for the project description.
    let projectDesc = LabelComponent(text: "Default", accessibilityLabel: "", textColor: .systemGray, font: .caption1, numberOfLines: 3, lineBreakMode: .byTruncatingTail)
       
    /// The label component for displaying the completion percentage.
    let projectPercentage: LabelComponent = {
        let label = LabelComponent(text: "Default", accessibilityLabel: "", textColor: .black, font: .largeTitle, numberOfLines: 1)
        label.textLabel.font = .systemFont(ofSize: 35, weight: .bold)
        return label
    }()
       
    /// The label component for displaying the "Progress" label.
    var percentageLabel: LabelComponent = {
        let label = LabelComponent(text: "Default", accessibilityLabel: "")
        label.textLabel.text = "\(String(localized: "ProgressLabelKey"))"
        label.textLabel.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    /// The vertical stack view for arranging the completion percentage and "Progress" label.
    let stackViewForPercentage: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
      stackView.alignment = .center
      stackView.distribution = .fill
        stackView.spacing = -1
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: -7, left: 0, bottom: 0, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// The main vertical stack view for arranging all the components.
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
    
    /// Initializes a `ContainerProjectsList` instance with project details and customization options.
    ///
    /// - Parameters:
    ///   - title: The title of the project.
    ///   - titleColor: The text color for the project title.
    ///   - description: The description of the project.
    ///   - descriptionColor: The text color for the project description.
    ///   - percentage: The completion percentage of the project.
    ///   - percentageColor: The text color for the completion percentage.
    ///   - imageIcon: The icon image for the project.
    ///   - imageIconColor: The tint color for the icon image.
    ///   - chevronColor: The tint color for the chevron icon.
    init(title: String, titleColor: UIColor = .black, description: String, descriptionColor: UIColor = .black, percentage: String, percentageColor: UIColor = .black, imageIcon: UIImage = UIImage(systemName: "ellipsis.message.fill")!, imageIconColor: UIColor = .white, chevronColor: UIColor = .white) {
        super.init(frame: .zero)
        
        projectTitle.textLabel.text = title
        projectTitle.textLabel.textColor = titleColor
        
        iconTitle.image = imageIcon
        iconTitle.tintColor = imageIconColor
        iconTitle.translatesAutoresizingMaskIntoConstraints = false
        iconTitle.contentMode = .scaleAspectFit
        
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.contentMode = .scaleAspectFit
        chevron.tintColor = chevronColor
        
        projectDesc.textLabel.text = description
        projectDesc.textLabel.textColor = descriptionColor
        
        projectPercentage.textLabel.text = percentage + "%"
        projectPercentage.textLabel.textColor = percentageColor
        percentageLabel.textLabel.textColor = percentageColor
        
        stackViewContainerTitle.addArrangedSubview(iconTitle)
        stackViewContainerTitle.addArrangedSubview(projectTitle)
        stackViewContainerTitle.addArrangedSubview(chevron)
        
        stackViewContainer.addArrangedSubview(projectDesc)
        
        stackViewContainer.addArrangedSubview(stackViewForPercentage)
        
        stackViewForPercentage.addArrangedSubview(projectPercentage)
        stackViewForPercentage.addArrangedSubview(percentageLabel)
        
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
            iconTitle.heightAnchor.constraint(equalToConstant: 38),
            iconTitle.widthAnchor.constraint(equalTo: iconTitle.heightAnchor),
            chevron.heightAnchor.constraint(equalToConstant: 25),
            chevron.widthAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}

#Preview {
  ContainerProjectsList(title: "Mini challenge 02", description: "Mude a perpectiva do mundo com njndjnf jnjjnfd coração", percentage: "100")
}
