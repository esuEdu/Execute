//
//  ModalGetInfoTask.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 01/10/23.
//

import UIKit

protocol ModalGetInfoTaskViewDelegate: AnyObject {
    func changeHappened(_ task: Task)
    func deleted(_ task: Task)
}

class ModalGetInfoTaskView: UIViewController{

    var viewModel: ModalGetInfoTaskViewModel?
    
    weak var delegate: ModalGetInfoTaskViewDelegate?
    
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    private var sheetDetents: Double = 246
    
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    var titleLabel: LabelComponent?
    
    var icon: ChooseIconComponent?
    
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
        label.text = String(localized: "startAt")
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelHour: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .closeButtom
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelOf: UILabel = {
        let label = UILabel()
        label.text = String(localized: "ofKey")
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .closeButtom
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
        view.backgroundColor = UIColor(.customBackground)
        icon = ChooseIconComponent(father: self)
        icon!.horizontalPadding = 10
        icon!.verticalPadding = 15
        icon!.translatesAutoresizingMaskIntoConstraints = false
        icon!.isBackgroung = false
        setUpModalConfiguration()
        verifyIfIsDone()
        setUpUI()
        addAllContraints()
        feedbackGenerator.prepare()
        notificationFeedbackGenerator.prepare()
    }
    
    func verifyIfIsDone(){
        if viewModel!.task!.isDone{
            buttonToFinish.changeIconSymbol(image: UIImage(systemName: "checkmark.circle.fill")!)
            buttonToFinish.layoutIfNeeded()
        } else{
            buttonToFinish.changeIconSymbol(image: UIImage(systemName: "checkmark.circle")!)
            buttonToFinish.layoutIfNeeded()
        }
    }
    
    func setUpUI() {
        
        view.backgroundColor = UIColor(.customBackground)
        titleLabel = LabelComponent(text: viewModel?.task?.name ?? "Teste", accessibilityLabel: "Teste")
        titleLabel?.stackView.layoutMargins = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 6)
        titleLabel?.textLabel.numberOfLines = 2
        titleLabel?.layer.cornerRadius = 10
        titleLabel?.backgroundColor = UIColor(.customSecondaryBlue)
        titleLabel?.textLabel.textColor = .closeButtom
        titleLabel?.textLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel?.textLabel.lineBreakMode = .byWordWrapping
        titleLabel?.textLabel.textAlignment = .left
        
        view.addSubview(generalStackView)
        generalStackView.addArrangedSubview(stackViewForTheTop)
        generalStackView.addArrangedSubview(stackViewForButtons)
        
        stackViewForTheTop.addArrangedSubview(icon!)
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
        icon!.changeColor(bgColor: UIColor.selectTheBestColor(color: viewModel!.getUIColor(), isBackground: false), tintColor: viewModel!.getUIColor())
      icon!.iconName = viewModel?.task?.icon
        
        buttonToFinish.addTarget(self, action: #selector(completeTask), for: .touchUpInside)
        buttonToFinish.addTarget(self, action: #selector(alphaButton), for: .touchDown)
        buttonToFinish.addTarget(self, action: #selector(disalphaButton), for: .touchCancel)
      
      buttonToEdit.addTarget(self, action: #selector(goToTaskEdition), for: .touchUpInside)
        
      
        buttonToDelete.addTarget(self, action: #selector(alphaButton), for: .touchDown)
        buttonToDelete.addTarget(self, action: #selector(disalphaButton), for: .touchCancel)
        buttonToDelete.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
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
            
            icon!.heightAnchor.constraint(equalToConstant: 75),
            icon!.widthAnchor.constraint(equalToConstant: 75),
            
            titleLabel!.bottomAnchor.constraint(equalTo: icon!.bottomAnchor),
            
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
    
    @objc func completeTask(_ button: UIButton){
        button.alpha = 1
        viewModel?.concludedTask()
        if viewModel!.task!.isDone{
            buttonToFinish.icon.image = UIImage(systemName: "checkmark.circle.fill")!
            buttonToFinish.layoutIfNeeded()
            viewModel?.done.toggle()
            self.dismiss(animated: true)
        } else{
            buttonToFinish.icon.image = UIImage(systemName: "checkmark.circle")!
            buttonToFinish.layoutIfNeeded()
            viewModel?.done.toggle()
        }
        delegate?.changeHappened(viewModel!.task!)
        feedbackGenerator.impactOccurred()
    }
  
    @objc func deleteTask(_ button: UIButton){
        button.alpha = 1
        let alert = UIAlertController(title: "", message: String(localized: "deleteTaskMessage"), preferredStyle: .actionSheet)
      self.feedbackGenerator.impactOccurred()
        alert.addAction(UIAlertAction(title: String(localized: "Delete"), style: .destructive){_ in
            self.notificationFeedbackGenerator.notificationOccurred(.warning)
            self.viewModel?.deleteTask()
            self.delegate?.deleted(self.viewModel!.task!)
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(UIAlertAction(title: String(localized: "Cancel"), style: .cancel){_ in
        })
        self.present(alert, animated: true)
    }
  
  @objc func goToTaskEdition() {
    viewModel?.goToEditView()
    self.dismiss(animated: true, completion: nil)
  }
    
    @objc func alphaButton(_ button: UIButton){
        button.alpha = 0.5
    }

    @objc func disalphaButton(_ button: UIButton){
        button.alpha = 1
    }

}

extension ModalGetInfoTaskView: UISheetPresentationControllerDelegate{
    
}
