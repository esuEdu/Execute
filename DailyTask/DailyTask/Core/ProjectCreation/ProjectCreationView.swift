//
//  ProjectCreationViewController.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import UIKit

class ProjectCreationView: UIViewController {
    
    var projectCreationViewModel: ProjectCreationViewModel?

    // MARK: - OFICIAL
    
    let iconButton: ChooseIconComponent = {
        let iconPicker = ChooseIconComponent()
        iconPicker.horizontalPadding = 10
        iconPicker.verticalPadding = 15
        iconPicker.iconName = "pencil.tip"
        iconPicker.translatesAutoresizingMaskIntoConstraints = false
        return iconPicker
    }()
    
    let textFieldToGetTheName: TextFieldToName = {
        let textField = TextFieldToName()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        #warning("NSLocalized")
        button.setTitle("Criar no projeto", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Não oficial
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite a descrição aqui"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let startDatePicker: DatePickerView <Date> = {
        let datePicker = DatePickerView <Date>()
        datePicker.datePickerMode = .dateAndTime
        return datePicker
    }()
    
    let endDatePicker: DatePickerView = {
        let datePicker = DatePickerView <Date>()
        datePicker.datePickerMode = .dateAndTime
        
        return datePicker
    }()
    
    #warning("Temporary")
    let methodologyButton: UIButton = {
        let methodologyButton = UIButton()
        methodologyButton.setTitleColor(.white, for: .normal)
        methodologyButton.backgroundColor = .systemCyan
        methodologyButton.layer.cornerRadius = 10
        methodologyButton.setTitle("Escolha sua metodologia", for: .normal)
        return methodologyButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        addAllConstraints()
        sendDateToViewModel()
    }
    
    func setUpUI(){
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = createRightButtom()
        self.navigationItem.leftBarButtonItem = createLeftButtom()
        self.title = "Criar projeto"
        self.view.addSubview(stackView)
        self.view.addSubview(iconButton)
        self.view.addSubview(textFieldToGetTheName)
        stackView.addArrangedSubview(methodologyButton)
        stackView.addArrangedSubview(startDatePicker)
        stackView.addArrangedSubview(endDatePicker)
        stackView.addArrangedSubview(descriptionTextField)
        
        view.addSubview(createButton)
        methodologyButton.menu = setMethodologyButton()
        iconButton.menu = setIcon()
        createButton.addTarget(self, action: #selector(defineProjectData), for: .touchUpInside)
    }

    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: iconButton.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            iconButton.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            iconButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            iconButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            iconButton.heightAnchor.constraint(equalToConstant: 93),
            iconButton.widthAnchor.constraint(equalToConstant: 93),
            
            textFieldToGetTheName.leadingAnchor.constraint(equalTo: iconButton.trailingAnchor, constant: 20),
            textFieldToGetTheName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldToGetTheName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            createButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            
        ])
    }
    
    #warning("REFATORAR")
    @objc func defineProjectData(){
        
        if (projectCreationViewModel?.compareDates() == .orderedAscending){
            self.projectCreationViewModel?.name = textFieldToGetTheName.textFieldToGetTheName.text == "" ? self.projectCreationViewModel?.name : textFieldToGetTheName.textFieldToGetTheName.text
            self.projectCreationViewModel?.description = descriptionTextField.text == "" ? self.projectCreationViewModel?.description : descriptionTextField.text
            
            self.projectCreationViewModel?.createAProject()
            self.projectCreationViewModel?.removeTopView()
        } else{
            print("")
            #warning("Temporary")
            let alert = UIAlertController(title: "Erro de criação", message: "Você não pode criar um projeto que termine no passado, a máquina do tempo não foi inventada ainda", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tentar de novo", style: .destructive))
            self.present(alert, animated: true)
        }
        
    }
    
    @objc func removeTheView(){
        projectCreationViewModel?.removeTopView()
    }

}

#warning("REFATORAR")
extension ProjectCreationView {

    func sendDateToViewModel(){
        startDatePicker.valueChangedHandler = { selectedDate in
            self.projectCreationViewModel?.start = selectedDate
            print(selectedDate)
        }
        
        endDatePicker.valueChangedHandler = { selectedDate in
            self.projectCreationViewModel?.end = selectedDate
            print(selectedDate)
        }
    }
    
    func createRightButtom() -> UIBarButtonItem{
        let buttonToContinue: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.title = "Concluido"
            button.target = self
            button.action = #selector(defineProjectData)
            return button
        }()

        return buttonToContinue
    }

    func createLeftButtom() -> UIBarButtonItem{
        let buttonToContinue: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.title = "Cancelar"
            button.tintColor = .systemRed
            button.target = self
            button.action = #selector(removeTheView)
            return button
        }()

        return buttonToContinue
    }

    func setIcon() -> UIMenu{
        let menuItems = UIMenu(title: "", options: .displayAsPalette, children: [
            
            UIAction(title: "Globo", image: UIImage(systemName: "globe.americas.fill"), handler: { _ in
                self.iconButton.iconName = "globe.americas.fill"
                self.projectCreationViewModel?.icon = self.iconButton.iconName
            }),
            
            UIAction(title: "PaperPlane", image: UIImage(systemName: "paperplane.fill"), handler: { _ in
                self.iconButton.iconName = "paperplane.fill"
                self.projectCreationViewModel?.icon = self.iconButton.iconName
            }),
            
            UIAction(title: "Pencil", image: UIImage(systemName: "pencil.tip.crop.circle.badge.plus") , handler: { _ in
                self.iconButton.iconName = "pencil.tip.crop.circle.badge.plus"
                self.projectCreationViewModel?.icon = self.iconButton.iconName
            }),
            
            
        ])
        
        return menuItems
    }
    
    func setMethodologyButton() -> UIMenu{
        let menuItems = UIMenu(title: "", options: .displayAsPalette, children: [
        
        UIAction(title: "CBL", image: UIImage(systemName: "globe.americas.fill"), handler: { _ in
            self.projectCreationViewModel?.methodology = .CBL
            self.methodologyButton.setTitle("Methodology \(String(describing: self.projectCreationViewModel!.methodology!.rawValue))", for: .normal)
        }),
        
        UIAction(title: "Scrum", image: UIImage(systemName: "paperplane.fill"), handler: { _ in
            self.projectCreationViewModel?.methodology = .Scrum
            self.methodologyButton.setTitle("Methodology \(String(describing: self.projectCreationViewModel!.methodology!.rawValue))", for: .normal)
        }),
        
        UIAction(title: "Custom", image: UIImage(systemName: "pencil.tip.crop.circle.badge.plus") , handler: { _ in
            self.projectCreationViewModel?.methodology = .Custom
            self.methodologyButton.setTitle("Methodology \(String(describing: self.projectCreationViewModel!.methodology!.rawValue))", for: .normal)
        }),
        
        
        ])
        
        return menuItems
    }
    

}

#Preview{
    ChooseIconComponent()
}


#Preview{
    ProjectCreationView()
}

class ColorPickerComponent: UIView{
    
    let stackViewForColors: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        return stackview
    }()
    
    let colorWell: UIColorWell = {
        let colorWell = UIColorWell()
        colorWell.selectedColor = .black
        colorWell.supportsAlpha = false
        #warning("NSlocalizable")
        colorWell.title = "Cor do projeto"
        colorWell.translatesAutoresizingMaskIntoConstraints = false
        return colorWell
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        addAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        backgroundColor = .systemIndigo
        layer.cornerRadius = 10
        addSubview(colorWell)
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            colorWell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            colorWell.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorWell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            colorWell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
}

class CustomColorButton: UIButton {
    
    private let radius: CGFloat = 150
    
    private let circlePath = CAShapeLayer()
    var defaultColor: CGColor = CGColor(red: 0.4, green: 0.2, blue: 1, alpha: 1) {
        didSet{
            self.circlePath.fillColor = self.defaultColor
        }
        
    }
    
    private let selectedCircle = CAShapeLayer()
    
    var path: UIBezierPath?
    var circularPath: UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.circularPath = UIBezierPath(arcCenter: CGPoint(x: 190, y: 850 / 2.0), radius: (radius * 2) / 3, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        self.path = UIBezierPath(arcCenter: CGPoint(x: 190, y: 850 / 2.0), radius: radius * 0.9, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        
        addCircleConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCircleConfig(){
        circlePath.path = path!.cgPath
        circlePath.fillColor = UIColor.clear.cgColor
        circlePath.lineWidth = radius / 5
        circlePath.lineCap = . square
        circlePath.strokeColor = UIColor.systemIndigo.cgColor
        
        selectedCircle.path = circularPath!.cgPath
        selectedCircle.fillColor = UIColor.systemIndigo.cgColor
        layer.addSublayer(selectedCircle)
        layer.addSublayer(circlePath)
    }
    
    func changeToSelectedButton(){
        
    }
    
}

#Preview {
    CustomColorButton()
}