//
//  ChooseIconComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 25/09/23.
//

import UIKit

/// A custom button to choose the icon (only Visual | Not functional)
///
///  `ChooseIconComponent` is a subclass of `UIButton` that provides visual elements to the button to choose the icons in the creation of a project or a task
///
/// ## How to use?
///
/// Just create the component like a button and change the horizontal and vertical padding to adapt the button in your design and choose the name of the icon, look at the example:
///
/// ```swift
/// let iconButton: ChooseIconComponent = {
///     let iconPicker = ChooseIconComponent()
///     iconPicker.horizontalPadding = 10
///     iconPicker.verticalPadding = 15
///     iconPicker.iconName = "pencil.tip"
///     iconPicker.color = .systemIndigo
///     iconPicker.bgColor = .white
///     iconPicker.translatesAutoresizingMaskIntoConstraints = false
///     return iconPicker
/// }()
/// ```
///
///
class ChooseIconComponent: UIButton {
    
    var verticalPadding: CGFloat = 16
    var horizontalPadding: CGFloat = 16
    var iconName: String? {
        didSet{
            setUpIconImage()
        }
    }
    var color: UIColor = .systemRed
    var bgColor: UIColor = .systemRed
    
    private let icon: UIImageView = {
        let UIIMageView = UIImageView()
        UIIMageView.image = UIImage(systemName: "pencil.tip")
        UIIMageView.tintColor = .white
        UIIMageView.contentMode = .scaleAspectFit
        UIIMageView.translatesAutoresizingMaskIntoConstraints = false
        return UIIMageView
    }()
    
    private let iconBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        addAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpIconDefinitions(verticalPadding: CGFloat, horizontalPadding: CGFloat, iconName: String, color: UIColor, bgColor: UIColor){
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.iconName = iconName
        self.color = color
        self.bgColor = bgColor
        self.icon.image = UIImage(systemName: iconName)
    }
    
    func setUpIconImage(){
        self.icon.image = UIImage(systemName: iconName!)!
    }
    
    func setUpUI(){
        self.backgroundColor = .systemIndigo
        self.layer.cornerRadius = 10
        addSubview(iconBox)
        iconBox.addSubview(icon)
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            iconBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconBox.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding),
            iconBox.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalPadding ),
            iconBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            iconBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding ),
            
            icon.topAnchor.constraint(equalTo: iconBox.topAnchor),
            icon.bottomAnchor.constraint(equalTo: iconBox.bottomAnchor),
            icon.leadingAnchor.constraint(equalTo: iconBox.leadingAnchor),
            icon.trailingAnchor.constraint(equalTo: iconBox.trailingAnchor),
        ])
    }
    
}
