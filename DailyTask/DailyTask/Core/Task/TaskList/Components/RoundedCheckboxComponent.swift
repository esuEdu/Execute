//
//  RoundedCheckboxComponent.swift
//  DailyTask
//
//  Created by Luca on 02/10/23.
//

import Foundation
import UIKit

protocol RoundedCheckboxDelegate: AnyObject{
    func buttonWasPressed(pressed: Bool)
}

/// A custom checkbox control for toggling a bool state.
///
/// `Checkbox` is a subclass of `UIControl` that provides a checkbox-like appearance
/// for toggling between two states: checked and unchecked.
///
/// ## Usage
///
/// To use `Checkbox`, create an instance and customize its appearance as needed. You can
/// set the initial state using the `checked` property and handle value changes with the
/// `.valueChanged` control event.
///
/// ```swift
/// let checkBox: Checkbox = {
///     let check = Checkbox()
///     check.tintColor = .green
///     return check
/// }()
/// ```
///
/// - Note: `Checkbox` provides a visual representation of a bool state with a checked
///         or unchecked appearance.
///
/// - Important: When the `checked` property changes, the control sends a `.valueChanged`
///              control event, allowing you to react to state changes.
///
/// - SeeAlso: `UIControl`
class RoundedCheckbox: UIControl {
    
    weak var delegate: RoundedCheckboxDelegate?
    
    private weak var imageView: UIImageView!
    
    private var image: UIImage {
        return checked ? UIImage(systemName: "circle.fill")! : UIImage(systemName: "circle")!
    }
    
    private var backgroundImage: UIImage = UIImage(systemName: "circle")!
    
    /// A boolean value that determines the checkbox state. `true` represents a checked
    /// state, while `false` represents an unchecked state.
    public var checked: Bool = false {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 26),
            imageView.heightAnchor.constraint(equalToConstant: 26)

        ])
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2.9
        
        if checked == true{
            imageView.layer.borderColor = UIColor.darkGray.cgColor
            
        } else{
            imageView.layer.borderColor = UIColor.systemBlue.cgColor
        }
        imageView.layer.cornerRadius = 13
        
        self.imageView = imageView
        
        backgroundColor = UIColor.clear
        imageView.tintColor = UIColor.systemBlue
        
        self.addTarget(self, action: #selector(touchCheckbox), for: .touchUpInside)
    }
    
    @objc func touchCheckbox() {
        checked = !checked
        if checked == true{
            UIView.animate(withDuration: 0.2) {
                self.imageView.layer.borderColor = UIColor.lightGray.cgColor
            }
        } else{
            UIView.animate(withDuration: 0.2) {
                self.imageView.layer.borderColor = UIColor.systemBlue.cgColor
            }
        }
        delegate?.buttonWasPressed(pressed: checked)
    }
    
}

#Preview{
    RoundedCheckbox()
}
