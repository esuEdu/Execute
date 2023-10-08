//
//  ColorChooseComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 27/09/23.
//

import UIKit

/// The `ColorChooseComponentDelegate` enables you to update your current color in real time based on the selected color
///
///## How to use?
///
/// You can set the color inside the funcion in your View or ViewModel, it will change automatically
///
///```swift
///extension ProjectCreationView: ColorChooseComponentDelegate {
///    func updateColor() {
///        let color = colorChooser.returnColorUIColor()
///        iconButton.changeColor(bgColor: color, tintColor: selectTheBestColor(color: color))
///    }
///}
///```
///
protocol ColorChooseComponentDelegate: AnyObject {
    func updateColor()
}

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
class ColorChooseComponent: UIView{
    
    weak var delegate: ColorChooseComponentDelegate?
    
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
//    let sjfis = UINotificationFeedbackGenerator()
//    let jdnfjdnj = UIFeedbackGenerator()
    
    // Variable used to get easily what color was selected
    private var theChoosenOne: ColorSelection?{
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
    
    private let colorWell: ColorPicker = {
        let colorPicker = ColorPicker()
        return colorPicker
    }()
    
    private let color1: CustomColorButton = {
        let color = CustomColorButton()
        color.colorName = .Red
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    private let color2: CustomColorButton = {
        let color = CustomColorButton()
        color.colorName = .Blue
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    private let color3: CustomColorButton = {
        let color = CustomColorButton()
        color.colorName = .Yellow
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    private let color4: CustomColorButton = {
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
        feedbackGenerator.prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Used when the color picker is the selected, it`s important in every changed deselect the other ones
    @objc private func chooseColorPicker(){
        print("OI")
        deselectAllButtons()
        theChoosenOne = ColorSelection.Custom
    }
    
    // Used when the color picker is not the selected, it`s important in every changed deselect the other ones
    @objc private func chooseButton(button: CustomColorButton){
        deselectAllButtons()
        
        button.isPressed = true
        button.layoutIfNeeded()
        theChoosenOne = button.colorName
        print("Escolhido \(theChoosenOne)")
        colorWell.selectedColor = .white
    }
    
    // Used just to selected only one color button
    func deselectAllButtons(){
        feedbackGenerator.impactOccurred(intensity: 0.7)
        
        color1.isPressed = false
        color2.isPressed = false
        color3.isPressed = false
        color4.isPressed = false
    }
    
    /// Change the start color of the color picker
    func changeColorPickerColor(color: UIColor){
        colorWell.selectedColor = color
    }
    
    #warning("Colocar as cores oficiais quando elas existirem!")
    /// Use this function to get the red, gree and blue of the user's selected color in CGFloat format
    ///
    ///## Return
    ///
    /// ```swift
    /// //r,    g,    b
    ///  [1.0, 0.4, 0.8]
    /// ```
    func returnColorCGFloat() -> [CGFloat]{
        if let theChoosenOne = theChoosenOne{
            switch theChoosenOne {
            case .Blue:
                let color = UIColor.systemBlue
                return [color.cgColor.components![0], color.cgColor.components![1],  color.cgColor.components![2]]
            case .Red:
                let color = UIColor.systemRed
                return [color.cgColor.components![0], color.cgColor.components![1],  color.cgColor.components![2]]
            case .Yellow:
                let color = UIColor.systemYellow
                return [color.cgColor.components![0], color.cgColor.components![1],  color.cgColor.components![2]]
            case .Green:
                let color = UIColor.systemGreen
                return [color.cgColor.components![0], color.cgColor.components![1],  color.cgColor.components![2]]
            case .Custom:
                if let colors = colorWell.selectedColor?.cgColor.components{
                    return [colors[0],colors[1],colors[2]]
                    
                }
            }
        }
        
        return [0,0,0]
        
    }
    
    #warning("Colocar as cores oficiais quando elas existirem!")
    /// Use this function to get the `UIColor` of the user's selected color
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

// Setting the colorWell configurations
class ColorPicker: UIColorWell{
    
    // It's import to not give the user permission to use the alpha scale
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
    // If you change the color name it execute the hierarchy and configuration of this view
    var colorName: ColorSelection? {
        didSet{
            setUpUI()
        }
    }
    
    // Variable used to know if the color button is pressed or not and change the image
    var isPressed: Bool = false{
        didSet{
            if isPressed{
                image.image = UIImage(named: "\(colorName?.rawValue ?? "Red")Selected")
            } else{
                image.image = UIImage(named: "\(colorName?.rawValue ?? "Red")Deselected")
            }
            
        }
    }
    
    // This is what change when is pressed or not
    private let image: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        image.image = UIImage(named: "\(colorName?.rawValue ?? "Red")Deselected")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        addAllConstraints()
    }
    
    private func addAllConstraints(){
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

