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
    
    func changeColor(bgColor: UIColor){
        self.backgroundColor = bgColor
    }
    
    func setUpUI(){
        self.backgroundColor = .systemRed
        self.layer.cornerRadius = 10
        addSubview(icon)
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor, constant: -verticalPadding),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: verticalPadding),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
        ])
    }
    
}
