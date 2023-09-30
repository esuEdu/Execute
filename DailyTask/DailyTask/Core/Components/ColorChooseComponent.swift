//
//  ColorChooseComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 27/09/23.
//

import UIKit

/// A custom components to choose the color of the project, task or tag
///
/// `ColorChooseComponent` is a subclass of `UIView` and have two diferrent components `ColorPicker` and the `CustomColorButton`
///
/// ## How to use?
///
/// The variable `theChoosenOne` set what color was selected by the user. You can use the functions `returnColorUIColor()` and `returnColorCGFloat` to get the color data
///
///```swift
/// let colorChooser = ColorChooseComponent()
/// colorChooser.returnColorUIColor()
/// colorChooser.returnColorCGFloat()
///```
///
/// They return CGFloat like RGB:
///
/// ```swift
/// //r,    g,    b
///  [1.0, 0.4, 0.8]
/// ```
///

protocol ColorChooseComponentDelegate: AnyObject {
    func updateColor()
}

class ColorChooseComponent: UIView{
    
    var delegate: ColorChooseComponentDelegate?
    
    var theChoosenOne: ColorSelection?{
        didSet{
            delegate?.updateColor()
        }
    }
    
    private let stackViewForColors: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        stackview.alignment = .center
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        return stackview
    }()
    
    let colorWell: ColorPicker = {
        let colorPicker = ColorPicker()
        return colorPicker
    }()
    
    let color1: CustomColorButton = {
        let color = CustomColorButton()
        color.colorName = .Red
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    let color2: CustomColorButton = {
        let color = CustomColorButton()
        color.colorName = .Blue
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    let color3: CustomColorButton = {
        let color = CustomColorButton()
        color.colorName = .Yellow
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    let color4: CustomColorButton = {
        let color = CustomColorButton()
        color.colorName = .Green
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setUpUI()
        addAllConstraints()
        color1.layer.cornerRadius = 50
        color1.addTarget(self, action: #selector(chooseButton), for: .touchUpInside)
        color2.addTarget(self, action: #selector(chooseButton), for: .touchUpInside)
        color3.addTarget(self, action: #selector(chooseButton), for: .touchUpInside)
        color4.addTarget(self, action: #selector(chooseButton), for: .touchUpInside)
        colorWell.addTarget(self, action: #selector(chooseColorPicker), for: .valueChanged)
        color1.isPressed = true
        color1.layoutIfNeeded()
        theChoosenOne = .Red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func chooseColorPicker(){
        print("OI")
        deselectAllButtons()
        theChoosenOne = ColorSelection.Custom
    }
    
    @objc private func chooseButton(button: CustomColorButton){
        deselectAllButtons()
        
        button.isPressed = true
        button.layoutIfNeeded()
        theChoosenOne = button.colorName
        colorWell.selectedColor = .white
    }
    
    private func deselectAllButtons(){
        color1.isPressed = false
        color2.isPressed = false
        color3.isPressed = false
        color4.isPressed = false
    }
    
    func changeColorPickerColor(color: UIColor){
        colorWell.selectedColor = color
    }
    
    #warning("Colocar as cores oficiais quando elas existirem!")
    func returnColorCGFloat() -> [CGFloat]{
        if let theChoosenOne = theChoosenOne{
            switch theChoosenOne {
            case .Blue:
                return [0.149, 0.5647, 0.5921]
            case .Red:
                return [0.898, 0.286, 0.1529]
            case .Yellow:
                return [1, 0.58, 0]
            case .Green:
                return [0.56, 0.7568, 0.2352]
            case .Custom:
                if let colors = colorWell.selectedColor?.cgColor.components{
                    return [colors[0],colors[1],colors[2]]
                    
                }
            }
        }
        
        return [0,0,0]
        
    }
    
    #warning("Colocar as cores oficiais quando elas existirem!")
    func returnColorUIColor() -> UIColor{
        if let theChoosenOne = theChoosenOne{
            switch theChoosenOne {
            case .Blue:
                return .systemBlue
            case .Red:
                return .systemRed
            case .Yellow:
                return .systemYellow
            case .Green:
                return .systemGreen
            case .Custom:
                return colorWell.selectedColor ?? .systemRed
            }
        }
        return UIColor.systemRed
    }
    
    private func setUpUI(){
        backgroundColor = .systemGray3
        layer.cornerRadius = 10
        addSubview(stackViewForColors)
        stackViewForColors.addArrangedSubview(color1)
        stackViewForColors.addArrangedSubview(color2)
        stackViewForColors.addArrangedSubview(color3)
        stackViewForColors.addArrangedSubview(color4)
        stackViewForColors.addArrangedSubview(colorWell)
    }
    
    private func addAllConstraints(){
        NSLayoutConstraint.activate([
            stackViewForColors.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackViewForColors.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackViewForColors.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewForColors.heightAnchor.constraint(equalToConstant: 27),
            
            colorWell.heightAnchor.constraint(equalTo: stackViewForColors.heightAnchor),
            colorWell.widthAnchor.constraint(equalTo: stackViewForColors.heightAnchor),
            
            color1.heightAnchor.constraint(equalTo: stackViewForColors.heightAnchor),
            color1.widthAnchor.constraint(equalTo: stackViewForColors.heightAnchor),
            
            color2.heightAnchor.constraint(equalTo: stackViewForColors.heightAnchor),
            color2.widthAnchor.constraint(equalTo: stackViewForColors.heightAnchor),
            
            color3.heightAnchor.constraint(equalTo: stackViewForColors.heightAnchor),
            color3.widthAnchor.constraint(equalTo: stackViewForColors.heightAnchor),
            
            color4.heightAnchor.constraint(equalTo: stackViewForColors.heightAnchor),
            color4.widthAnchor.constraint(equalTo: stackViewForColors.heightAnchor),
            
        ])
    }
    
    
}

class ColorPicker: UIColorWell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        selectedColor = .white
        supportsAlpha = false
        title = "Cor do projeto"
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


///
/// A custom button to toggle the selected color
///
/// ## How to use?
/// Create the intance of the button by selecting the especific name of the color, that can be red, green, blue, yellow and custom:
///
/// ```swift
/// let customButton: CustomColorButton()
/// customButton.colorName = .Red
/// ```
///
class CustomColorButton: UIButton {
    var colorName: ColorSelection? {
        didSet{
            setUpUI()
        }
    }
    
    var isPressed: Bool = false{
        didSet{
            if isPressed{
                image.image = UIImage(named: "\(colorName?.rawValue ?? "Red")Selected")
            } else{
                image.image = UIImage(named: "\(colorName?.rawValue ?? "Red")Deselected")
            }
            
        }
    }
    
    private let image: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        image.image = UIImage(named: "\(colorName?.rawValue ?? "Red")Deselected")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        addAllConstraints()
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

/// Define the selected color in a `CustomColorButton`
enum ColorSelection: String{
    case Blue = "Blue"
    case Red = "Red"
    case Yellow = "Yellow"
    case Green = "Green"
    case Custom = ""
}

#Preview {
    ColorChooseComponent()
}

