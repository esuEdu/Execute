//
//  ProjectEditionView.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 05/10/23.
//

import UIKit

class ProjectEditionView: UIViewController {
    
    var isEditable: Bool = false

    var viewModel: ProjectEditionViewModel?
    
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
        iconPicker.isSelectable = true
        iconPicker.translatesAutoresizingMaskIntoConstraints = false
        return iconPicker
    }()
    
    let textFieldToGetTheName: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.layer.zPosition = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let colorChooser: ColorChooseComponent = {
        let colorChooser = ColorChooseComponent()
        colorChooser.layer.zPosition = 9
        return colorChooser
    }()
    
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
    let methodologyButton: ChooseMethodologyComponent = {
        let met = ChooseMethodologyComponent(font: UIFont.preferredFont(forTextStyle: .body), text: "Challenge Based Learning (CBL)", textColor: .label)
        return met
    }()
    
    
    var dateContainer: ContainerComponent?
    let deadLine: DeadlineComponent = {
        let deadLine = DeadlineComponent()
        
        return deadLine
    }()
    
    
    var descriptionContainer: ContainerComponent?
    let descriptionTextField: TextDescriptionComponent = {
        let textField = TextDescriptionComponent(placeholderColor: .systemGray, textColor: .label)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.horizontalPadding = 10
        textField.verticalPadding = 10
        return textField
    }()

    let updateButton: UIButton = {
        let button = UIButton(primaryAction: nil)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle(String(localized: "Create a new project"), for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(primaryAction: nil)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle(String(localized: "Create a new project"), for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let barButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: ProjectEditionView.self, action: nil)
    
    let pencilEditor1: UIButton = {
        let pencil = UIButton()
        pencil.setImage(UIImage(systemName: "pencil"), for: .normal)
        pencil.isUserInteractionEnabled = false
        pencil.contentMode = .scaleAspectFit
        pencil.tintColor = .black
        return pencil
    }()
    
    let pencilEditor2: UIButton = {
        let pencil = UIButton()
        pencil.setImage(UIImage(systemName: "pencil"), for: .normal)
        pencil.isUserInteractionEnabled = false
        pencil.tintColor = .black
        pencil.contentMode = .scaleAspectFit
        return pencil
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgColor = UIColor(red: viewModel!.project!.red, green: viewModel!.project!.green, blue: viewModel!.project!.blue, alpha: 1)
        
        colorChooser.deselectAllButtons()
        colorChooser.layoutIfNeeded()
        
        setUpDelegates()
        setUpUI()
        addAllConstraints()
        selectionFeedbackGenerator.prepare()
        
        verifyIfIsEditable()
        
        textFieldToGetTheName.textFieldToGetTheName.text = viewModel?.project?.name
        methodologyButton.methodology.text = viewModel?.project?.methodology
        deadLine.startDatePicker.setDate((viewModel?.project?.start) ?? Date.now, animated: true)
        deadLine.endDatePicker.setDate((viewModel?.project?.end) ?? Date.now, animated: true)
        descriptionTextField.descriptionBox.text = viewModel?.project?.descript
        iconButton.changeColor(bgColor: bgColor, tintColor: UIColor.selectTheBestColor(color: bgColor, isBackground: true))
        iconButton.iconName = viewModel?.project?.icon
    }
    
    func verifyIfIsEditable(){
        if isEditable {
            pencilEditor1.isHidden = false
            self.iconButton.isUserInteractionEnabled = true
            self.descriptionTextField.isUserInteractionEnabled = true
            self.deadLine.isUserInteractionEnabled = true
            self.methodologyButton.hideButton(false)
            self.textFieldToGetTheName.isUserInteractionEnabled = true
            self.colorChooser.isHidden = false
            self.navigationItem.rightBarButtonItem = self.createRightButtom()
            self.navigationItem.leftBarButtonItem = self.createLeftButtom()
            self.stackViewForTitleAndColor.isLayoutMarginsRelativeArrangement = false
            self.updateButton.isHidden = false
            self.deleteButton.isHidden = false
            isEditable.toggle()
        } else {
            pencilEditor1.isHidden = true
            self.iconButton.isUserInteractionEnabled = false
            self.descriptionTextField.isUserInteractionEnabled = false
            self.deadLine.isUserInteractionEnabled = false
            self.methodologyButton.hideButton(true)
            self.textFieldToGetTheName.isUserInteractionEnabled = false
            self.colorChooser.isHidden = true
            self.barButton.menu = self.menu()
            self.navigationItem.rightBarButtonItem = self.barButton
            self.navigationItem.leftBarButtonItem = nil
            self.stackViewForTitleAndColor.isLayoutMarginsRelativeArrangement = true
            self.stackViewForTitleAndColor.layoutMargins = UIEdgeInsets(top: 19, left: 0, bottom: 19, right: 0)
            self.updateButton.isHidden = true
            self.deleteButton.isHidden = true
            isEditable.toggle()
        }
    }
    
    func setUpDelegates(){
        methodologyButton.delegate = self
        colorChooser.delegate = self
        iconButton.delegate = self
    }
    
    func setUpUI(){
        dateContainer = ContainerComponent(text: String(localized: "Deadline"), textColor: .white, components: [deadLine])
        
        descriptionContainer = ContainerComponent(text: String(localized: "Description"),textColor: .white, button: pencilEditor1, components: [descriptionTextField])
        
        methodologyContainer = ContainerComponent(text: String(localized: "Methodology"), textColor: .white, components: [methodologyButton])
        methodologyContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        navigationController?.isNavigationBarHidden = false
        
        self.view.backgroundColor = .systemBackground
        
        self.title = String(localized: "Name the project")
        
        
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
        
        
        stackViewForTheContainer.addArrangedSubview(updateButton)
        stackViewForTheContainer.addArrangedSubview(deleteButton)
        updateButton.addTarget(self, action: #selector(defineProjectData), for: .touchUpInside)
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
            
//            deleteButton.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 12),
            
            descriptionTextField.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func defineProjectData(){
        
        
        if (viewModel?.compareDates() == .orderedAscending){
            self.viewModel?.name = textFieldToGetTheName.getText() == "" ? self.viewModel?.name : textFieldToGetTheName.textFieldToGetTheName.text
            self.viewModel?.description = descriptionTextField.getText() == "" ? self.viewModel?.description : descriptionTextField.getText()
            viewModel?.editProject()
            verifyIfIsEditable()
        }else{
            let alert = UIAlertController(title: "Erro de criação", message: "Você não pode criar um projeto que termine no passado", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tentar de novo", style: .cancel))
            self.present(alert, animated: true)
        }
        
        selectionFeedbackGenerator.selectionChanged()
        
    }
    
    @objc func showMenu(){
        
    }
    
    @objc func removeTheView(){
        isEditable = false
        verifyIfIsEditable()
    }
    
    @objc func getStartDate(_ sender: UIDatePicker){
        let selectedDate = sender.date
        viewModel!.start = selectedDate
    }
    
    @objc func getEndDate(_ sender: UIDatePicker){
        let selectedDate = sender.date
        viewModel!.end = selectedDate
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

extension ProjectEditionView {
    
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

    func menu() -> UIMenu {
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Editar", image: nil, handler: { _ in
                self.verifyIfIsEditable()
        }),
            UIAction(title: "Deletar", image: nil, attributes: .destructive, handler: { _ in
                let alert = UIAlertController(title: "Tem certeza?", message: "Essa ação será irreversível!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Sim", style: .destructive, handler: { _ in
                    self.viewModel?.removeProject()
                    self.viewModel?.removeTopView()
                }))
                alert.addAction(UIAlertAction(title: "Não", style: .cancel))
                self.present(alert, animated: true)
        })
        ])
        
        return menuItems
    }
}

extension ProjectEditionView: ChooseMethodologyComponentDelegate {
    
    func setUpMenuFunction(type: Methodologies) {
        self.viewModel?.selectedMethodology(type)
        self.methodologyButton.changeTheMethodologyText(String(describing: self.viewModel!.methodology!))
    }
}

extension ProjectEditionView: ColorChooseComponentDelegate, ChooseIconComponentDelegate {
    func menuWasPressed(_ menuIcon: String) {
        self.viewModel?.selectedIcon(menuIcon)
        iconButton.iconName = menuIcon
    }
    
    func updateColor() {
        let color = colorChooser.returnColorUIColor()
        let CGColor = colorChooser.returnColorCGFloat()
        iconButton.changeColor(bgColor: color, tintColor: UIColor.selectTheBestColor(color: color, isBackground: true))
        viewModel?.red = CGColor[0]
        viewModel?.green = CGColor[1]
        viewModel?.blue = CGColor[2]
    }

}

