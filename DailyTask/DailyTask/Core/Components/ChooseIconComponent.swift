//
//  ChooseIconComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 25/09/23.
//

import UIKit

/// This protcol is used to pass what was the string of the selected icon
protocol ChooseIconComponentDelegate: AnyObject{
    func menuWasPressed(_ menuIcon: String)
}

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
    
    weak var delegate: ChooseIconComponentDelegate?
    
    var verticalPadding: CGFloat = 16
    var horizontalPadding: CGFloat = 16
    var isSelectable: Bool = false {
        didSet{
            setIcon()
        }
    }
    var iconName: String? {
        didSet{
            setUpIconImage()
        }
    }
    
    var isBackgroung: Bool = false
    
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
    
    // With this function you can managed the icon image out of this class
    private func setUpIconImage(){
        self.icon.image = UIImage(systemName: iconName!)!
    }
    
    /// Function that change the icon and background color of this component
    ///
    /// - Note: You can use it with the `ColorChooseComponentDelegate` function `updateColor()` to change automatically the selected color in the color well
    ///
    func changeColor(bgColor: UIColor, tintColor: UIColor){
        self.backgroundColor = bgColor
        icon.tintColor = tintColor
    }
    
    private func setUpUI(){
        if isBackgroung{
            self.backgroundColor = .systemRed
            icon.tintColor = .white
        } else{
            self.backgroundColor = .systemGray5
            icon.tintColor = .systemRed
        }
        
        self.layer.cornerRadius = 10
        addSubview(icon)
    }
    
    private func addAllConstraints(){
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor, constant: -verticalPadding),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: verticalPadding),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
        ])
    }
    
    private func setIcon(){

        let menuItems = UIMenu(title: "", options: .displayAsPalette, children: [
            
            UIAction(title: "Globo", image: UIImage(systemName: "globe.americas.fill"), handler: { _ in
                self.delegate?.menuWasPressed("globe.americas.fill")
            }),
            
            UIAction(title: "PaperPlane", image: UIImage(systemName: "paperplane.fill"), handler: { _ in
                self.delegate?.menuWasPressed("paperplane.fill")
            }),
            
            UIAction(title: "Pencil", image: UIImage(systemName: "umbrella.fill") , handler: { _ in
                self.delegate?.menuWasPressed("umbrella.fill")
            }),
            
            UIAction(title: "Pencil tip", image: UIImage(systemName: "pencil.tip") , handler: { _ in
                self.delegate?.menuWasPressed("pencil.tip")
            }),
            
            UIAction(title: "Dumbbell", image: UIImage(systemName: "dumbbell.fill") , handler: { _ in
                self.delegate?.menuWasPressed("dumbbell.fill")
            }),
            
            
        ])
        
        self.menu = menuItems
        self.showsMenuAsPrimaryAction = true
    }
    
}
