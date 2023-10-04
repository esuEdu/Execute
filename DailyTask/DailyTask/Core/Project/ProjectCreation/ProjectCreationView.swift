//
//  ProjectCreationViewController.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import UIKit

class ProjectCreationView: UIViewController {
    
    var projectCreationViewModel: ProjectCreationViewModel?
    
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()

    // MARK: - OFICIAL
    
    let stackViewForTitleAndColor = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let stackViewForIcon = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let iconButton: ChooseIconComponent = {
        let iconPicker = ChooseIconComponent()
        iconPicker.horizontalPadding = 10
        iconPicker.verticalPadding = 15
        iconPicker.iconName = "pencil.tip"
        iconPicker.isSelectable = true
        iconPicker.translatesAutoresizingMaskIntoConstraints = false
        return iconPicker
    }()
    
    let textFieldToGetTheName: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let colorChooser = ColorChooseComponent()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    let stackViewForTheContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        return stackView
    }()
    
    var methodologyContainer: ContainerComponent?
    let methodologyButton: ChooseMethodologyComponent = ChooseMethodologyComponent(font: UIFont.preferredFont(forTextStyle: .body), text: "Challenge Based Learning (CBL)", textColor: .black)
    
    
    var dateContainer: ContainerComponent?
    let deadLine: DeadlineComponent = {
        let deadLine = DeadlineComponent()
        return deadLine
    }()
    
    
    var descriptionContainer: ContainerComponent?
    let descriptionTextField: TextDescriptionComponent = {
        let textField = TextDescriptionComponent(placeholderColor: .systemGray, textColor: .black)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.horizontalPadding = 10
        textField.verticalPadding = 10
        return textField
    }()

    let createButton: UIButton = {
        let button = UIButton(primaryAction: nil)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle(String(localized: "Create a new project"), for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        setUpUI()
        addAllConstraints()
        selectionFeedbackGenerator.prepare()
    }
    
    func setUpDelegates(){
        methodologyButton.delegate = self
        colorChooser.delegate = self
        iconButton.delegate = self
    }
    
    func setUpUI(){
        dateContainer = ContainerComponent(text: String(localized: "Deadline"), textColor: .black, components: [deadLine])
        
        descriptionContainer = ContainerComponent(text: String(localized: "Description"), textColor: .black, components: [descriptionTextField])
        
        methodologyContainer = ContainerComponent(text: String(localized: "Methodology"), textColor: .black, components: [methodologyButton])
        methodologyContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = createRightButtom()
        self.navigationItem.leftBarButtonItem = createLeftButtom()
        self.title = String(localized: "Create a project")
        
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(stackViewForTheContainer)
        stackViewForTheContainer.addArrangedSubview(stackViewForIcon)
        stackViewForTheContainer.addArrangedSubview(methodologyContainer!)
        stackViewForTheContainer.addArrangedSubview(dateContainer!)
        stackViewForTheContainer.addArrangedSubview(descriptionContainer!)
        stackViewForIcon.addArrangedSubview(iconButton)
        stackViewForIcon.addArrangedSubview(stackViewForTitleAndColor)
        stackViewForTitleAndColor.addArrangedSubview(textFieldToGetTheName)
        stackViewForTitleAndColor.addArrangedSubview(colorChooser)
        
        
        stackViewForTheContainer.addArrangedSubview(createButton)
        createButton.addTarget(self, action: #selector(defineProjectData), for: .touchUpInside)
        iconButton.changeColor(bgColor: .systemRed , tintColor: UIColor.selectTheBestColor(color: .systemRed, isBackground: true))
        
        deadLine.startDatePicker.addTarget(self, action: #selector(getStartDate), for: .valueChanged)
        deadLine.endDatePicker.addTarget(self, action: #selector(getEndDate), for: .valueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }

    func addAllConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackViewForTheContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackViewForTheContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackViewForTheContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackViewForTheContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackViewForTheContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            iconButton.widthAnchor.constraint(equalToConstant: 93),
            iconButton.heightAnchor.constraint(equalToConstant: 93),
            
            descriptionTextField.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    #warning("REFATORAR")
    @objc func defineProjectData(){
        projectCreationViewModel?.colors = colorChooser.returnColorCGFloat()
        
        if (projectCreationViewModel?.compareDates() == .orderedAscending){
            self.projectCreationViewModel?.name = textFieldToGetTheName.getText() == "" ? self.projectCreationViewModel?.name : textFieldToGetTheName.textFieldToGetTheName.text
            self.projectCreationViewModel?.description = descriptionTextField.getText() == "" ? self.projectCreationViewModel?.description : descriptionTextField.getText()
            
            self.projectCreationViewModel?.createAProject()
            self.projectCreationViewModel?.removeTopView()
        } else{
            print("")
            #warning("Temporary")
            let alert = UIAlertController(title: "Erro de criação", message: "Você não pode criar um projeto que termine no passado, a máquina do tempo não foi inventada ainda", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tentar de novo", style: .destructive))
            self.present(alert, animated: true)
        }
        selectionFeedbackGenerator.selectionChanged()
        
    }
    
    @objc func removeTheView(){
        projectCreationViewModel?.removeTopView()
    }
    
    @objc func getStartDate(_ sender: UIDatePicker){
        let selectedDate = sender.date
        print("\(selectedDate)")
        projectCreationViewModel?.start = selectedDate
    }
    
    @objc func getEndDate(_ sender: UIDatePicker){
        let selectedDate = sender.date
        print("\(selectedDate)")
        projectCreationViewModel?.end = selectedDate
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

}

#warning("REFATORAR")
extension ProjectCreationView {
    
    func createRightButtom() -> UIBarButtonItem{
        let buttonToContinue: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.title = String(localized: "Done")
            button.target = self
            button.action = #selector(defineProjectData)
            return button
        }()

        return buttonToContinue
    }

    func createLeftButtom() -> UIBarButtonItem{
        let buttonToContinue: UIBarButtonItem = {
            let button = UIBarButtonItem()
            button.title = String(localized: "Cancel")
            button.tintColor = .systemRed
            button.target = self
            button.action = #selector(removeTheView)
            return button
        }()
        
        return buttonToContinue
    }

}

extension ProjectCreationView: ChooseMethodologyComponentDelegate {
    
    func setUpMenuFunction(type: Methodologies) {
        self.projectCreationViewModel?.selectedMethodology(type)
        self.methodologyButton.changeTheMethodologyText("\(String(describing: self.projectCreationViewModel!.methodology!.rawValue))")
    }
}

extension ProjectCreationView: ColorChooseComponentDelegate, ChooseIconComponentDelegate {
    func menuWasPressed(_ menuIcon: String) {
        self.projectCreationViewModel?.selectedIcon(menuIcon)
        iconButton.iconName = menuIcon
    }
    
    func updateColor() {
        let color = colorChooser.returnColorUIColor()
        iconButton.changeColor(bgColor: color, tintColor: UIColor.selectTheBestColor(color: color, isBackground: true))
    }

}

#Preview{
    ProjectCreationView()
}
