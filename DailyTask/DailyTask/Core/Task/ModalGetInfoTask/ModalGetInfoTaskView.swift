//
//  ModalGetInfoTask.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 01/10/23.
//

import UIKit

protocol ModalGetInfoTaskViewDelegate: AnyObject {
    func changeHappened()
}

class ModalGetInfoTaskView: UIViewController{

    var viewModel: ModalGetInfoTaskViewModel?
    
    var delegate: ModalGetInfoTaskViewDelegate?
    
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    private var sheetDetents: Double = 246
    
    var titleLabel: LabelComponent?
    
    let icon: ChooseIconComponent = {
        let icon = ChooseIconComponent()
        icon.horizontalPadding = 10
        icon.verticalPadding = 15
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.isBackgroung = false
        return icon
    }()
    
    let generalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var stackViewForLabel: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let labelStartAt: UILabel = {
        let label = UILabel()
        label.text = "Start at "
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelHour: UILabel = {
        let label = UILabel()
        label.text = "2 AM"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelOf: UILabel = {
        let label = UILabel()
        label.text = ", of "
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelDate: UILabel = {
        let label = UILabel()
        label.text = "09/28/2023"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackViewForDateAndLabel: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 9
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let stackViewForTheTop: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let stackViewForButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 22
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let buttonToDelete: ModalSquareComponent = {
        let icon: ModalSquareComponent = ModalSquareComponent(text: String(localized: "Delete"), iconImage: UIImage(systemName: "trash.fill")!)
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let buttonToEdit: ModalSquareComponent = {
        let icon: ModalSquareComponent = ModalSquareComponent(text: String(localized: "Edit"), iconImage: UIImage(systemName: "square.and.pencil")!)
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let buttonToFinish: ModalSquareComponent = {
        let icon: ModalSquareComponent = ModalSquareComponent(text: String(localized: "Done"), iconImage: UIImage(systemName: "checkmark.circle.fill")!)
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpModalConfiguration()
        setUpUI()
        addAllContraints()
    }
    
    func setUpUI(){
        view.backgroundColor = .systemBackground
        titleLabel = LabelComponent(text: viewModel?.task?.name ?? "Teste", accessibilityLabel: "Teste")
        titleLabel?.stackView.layoutMargins = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 6)
        titleLabel?.textLabel.numberOfLines = 2
        titleLabel?.layer.cornerRadius = 10
        titleLabel?.backgroundColor = .systemGray3
        titleLabel?.textLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        titleLabel?.textLabel.lineBreakMode = .byWordWrapping
        titleLabel?.textLabel.textAlignment = .left
        
        view.addSubview(generalStackView)
        generalStackView.addArrangedSubview(stackViewForTheTop)
        generalStackView.addArrangedSubview(stackViewForButtons)
        
        stackViewForTheTop.addArrangedSubview(icon)
        stackViewForTheTop.addArrangedSubview(stackViewForDateAndLabel)
        stackViewForDateAndLabel.addArrangedSubview(stackViewForLabel)
        stackViewForDateAndLabel.addArrangedSubview(titleLabel!)
        
        stackViewForLabel.addArrangedSubview(labelStartAt)
        stackViewForLabel.addArrangedSubview(labelHour)
        stackViewForLabel.addArrangedSubview(labelOf)
        stackViewForLabel.addArrangedSubview(labelDate)
        
        stackViewForButtons.addArrangedSubview(buttonToDelete)
        stackViewForButtons.addArrangedSubview(buttonToEdit)
        stackViewForButtons.addArrangedSubview(buttonToFinish)
        
        labelHour.text = viewModel?.getHour()
        labelDate.text = viewModel?.getDate()
        icon.changeColor(bgColor: selectTheBestColor(color: viewModel!.getUIColor(), isBackground: false), tintColor: viewModel!.getUIColor())
        
        buttonToFinish.addTarget(self, action: #selector(completeTask), for: .touchUpInside)
    }
    
    func setUpModalConfiguration(){
        sheetPresentationController?.delegate = self
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.preferredCornerRadius = 10
        sheetPresentationController?.detents = [.custom(resolver: { context in
            return self.sheetDetents
        })]
    }
    
    func addAllContraints(){
        NSLayoutConstraint.activate([
            generalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            generalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            generalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            icon.heightAnchor.constraint(equalToConstant: 75),
            icon.widthAnchor.constraint(equalToConstant: 75),
            
            titleLabel!.bottomAnchor.constraint(equalTo: icon.bottomAnchor),
            
            stackViewForLabel.heightAnchor.constraint(equalTo: labelStartAt.heightAnchor),
            
            labelStartAt.trailingAnchor.constraint(equalTo: labelHour.leadingAnchor),
            labelHour.leadingAnchor.constraint(equalTo: labelStartAt.trailingAnchor),
            labelHour.trailingAnchor.constraint(equalTo: labelOf.leadingAnchor),
            labelOf.leadingAnchor.constraint(equalTo: labelHour.trailingAnchor),
            labelOf.trailingAnchor.constraint(equalTo: labelDate.leadingAnchor),
            labelDate.leadingAnchor.constraint(equalTo: labelOf.trailingAnchor),
            
            buttonToFinish.heightAnchor.constraint(equalTo: stackViewForButtons.heightAnchor),

        ])
    }
    
    @objc func completeTask(){
        viewModel?.concludedTask()
        if viewModel!.done{
            buttonToFinish.icon.image = UIImage(systemName: "checkmark.circle.fill")!
            buttonToFinish.layoutIfNeeded()
            viewModel?.done.toggle()
        } else{
            buttonToFinish.icon.image = UIImage(systemName: "checkmark.circle")!
            buttonToFinish.layoutIfNeeded()
            viewModel?.done.toggle()
        }
        print("Cheguei")
        
    }

}

extension ModalGetInfoTaskView: UISheetPresentationControllerDelegate{
    
}
