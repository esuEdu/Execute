//
//  ModalSquareComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 30/09/23.
//

import UIKit

/// `ModalSquareComponent` is a custom UIButton subclass that represents a square modal component with an icon and a label.
///
/// Example usage:
///
/// ```swift
/// let modalComponent = ModalSquareComponent(text: "Sample", iconImage: UIImage(systemName: "backpack")!)
/// ```
///
/// This component provides a square button with an icon and a label, typically used for modal actions or options.
class ModalSquareComponent: UIButton {

    /// The icon image view.
    let icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "backpack")
        icon.tintColor = UIColor(.customIcon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    /// The label displaying text.
    var label: UILabel = UILabel()
    
    /// The main stack view that contains the icon and label.
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    /// Initializes a new `ModalSquareComponent` with the given text and icon image.
    ///
    /// - Parameters:
    ///   - text: The text to display.
    ///   - iconImage: The icon image to display.
    init(text: String, iconImage: UIImage) {
        super.init(frame: .zero)
        backgroundColor = UIColor(.customPrimaryBlue)
        layer.cornerRadius = 10
        icon.image = iconImage
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        addSubview(stackView)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(label)
        addAllConstraints()
    }
    
    /// Required initializer that is not implemented for this class.
    ///
    /// - Parameter coder: The NSCoder used for encoding and decoding.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Changes the icon symbol to the provided image.
    ///
    /// - Parameter image: The new icon image.
    func changeIconSymbol(image: UIImage) {
        icon.image = image
        icon.layoutIfNeeded()
    }
    
    /// Adds all necessary constraints for the component.
    private func addAllConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heightAnchor.constraint(equalTo: stackView.heightAnchor),
            icon.heightAnchor.constraint(equalToConstant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}

#Preview{
    ModalSquareComponent(text: "Teste", iconImage: UIImage(systemName: "checkmark.circle.fill")!)
}
