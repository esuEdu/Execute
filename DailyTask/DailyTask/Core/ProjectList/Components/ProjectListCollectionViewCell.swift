//
//  ProjectListTableViewCell.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 23/09/23.
//

import UIKit

class ProjectListCollectionViewCell: UICollectionViewCell {
    
    var projectManager = ProjectManager()

    static let identifier = "ProjectListTableViewCell"
    var icon: String?
    var name: String?
    var descript: String?
    var methodology: Methodologies?
    var start: Date?
    var end: Date?
    var progress: Int = 50
    
    let lableForTitleDescription: UILabel = {
        let hdLabel = UILabel()
        hdLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        hdLabel.translatesAutoresizingMaskIntoConstraints = false
        return hdLabel
    }()
    
    let labelForDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.text = "lorem kdhfjdfoj dd jdijfioejdio fjdoihf dohfoidjpfojpo jpoj oeijh oiheiofheoi hiohfoi ehiofh oeihfioh eoihfio ehihoif heoih ioehiohfioeh iohfeiohfioehioh eihf ioehihfioeh ioeh ioehfoih feiohfioejj ifeji jfeijfioje jfoej oejfie"
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackViewForDates: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let labelForHeadline: UILabel = {
        let hdLabel = UILabel()
        hdLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        hdLabel.text = "Prazo: "
        hdLabel.translatesAutoresizingMaskIntoConstraints = false
        return hdLabel
    }()
    
    let labelForDate1: UILabel = {
        let dataLabel = UILabel()
        dataLabel.text = "15 de Outubro"
        dataLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        return dataLabel
    }()
    
    let labelForDate2: UILabel = {
        let dataLabel = UILabel()
        dataLabel.text = "às"
        dataLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        dataLabel.textColor = .systemGray2
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        return dataLabel
    }()
    
    let labelForDate3: UILabel = {
        let dataLabel = UILabel()
        dataLabel.text = "14h05"
        dataLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        return dataLabel
    }()
    
    let viewsForDates: UIView = {
        let dataView = UIView()
        dataView.backgroundColor = .systemGray5
        dataView.layer.cornerRadius = 6
        dataView.translatesAutoresizingMaskIntoConstraints = false
        return dataView
    }()
    
    let stackViewForButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 40
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let buttonToContinue: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar projeto", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buttonToDetails: UIButton = {
        let button = UIButton()
        button.setTitle("Detalhes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let viewForTasks: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewForTags: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelForShowingTasks: UILabel = {
        let label = UILabel()
        label.text = "Próximas tarefas"
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIIfIsExpanded()
        constraintsIfIsExpanded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Expanded UI
    
    func setUpUIIfIsExpanded(){
        contentView.addSubview(stackViewForButtons)
        stackViewForButtons.addArrangedSubview(buttonToContinue)
        stackViewForButtons.addArrangedSubview(buttonToDetails)
        contentView.addSubview(viewForTasks)
        contentView.addSubview(viewForTags)
        viewForTasks.addSubview(labelForShowingTasks)
        contentView.addSubview(viewsForDates)
        
        viewsForDates.addSubview(stackViewForDates)
        
        stackViewForDates.addArrangedSubview(labelForDate1)
        stackViewForDates.addArrangedSubview(labelForDate2)
        stackViewForDates.addArrangedSubview(labelForDate3)
    }
    
//    UIImage(systemName: "control") Lembrar de usar isso!
    func constraintsIfIsExpanded(){
        NSLayoutConstraint.activate([
            stackViewForButtons.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackViewForButtons.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            stackViewForButtons.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            stackViewForButtons.heightAnchor.constraint(equalToConstant: 34),
            
            viewForTasks.bottomAnchor.constraint(equalTo: stackViewForButtons.topAnchor, constant: -15),
            viewForTasks.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            viewForTasks.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            viewForTasks.heightAnchor.constraint(equalToConstant: 100),
            
            labelForShowingTasks.leadingAnchor.constraint(equalTo: viewForTasks.leadingAnchor, constant: 8),
            labelForShowingTasks.topAnchor.constraint(equalTo: viewForTasks.topAnchor, constant: 7),
            
            viewForTags.bottomAnchor.constraint(equalTo: viewForTasks.topAnchor, constant: -12),
            viewForTags.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            viewForTags.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            viewForTags.heightAnchor.constraint(equalToConstant: 30),
            
            viewsForDates.bottomAnchor.constraint(equalTo: viewForTags.topAnchor, constant: -12),
            viewsForDates.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            viewsForDates.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            viewsForDates.topAnchor.constraint(equalTo: viewsForDates.bottomAnchor, constant: -25),
            
            
            stackViewForDates.trailingAnchor.constraint(equalTo: viewsForDates.trailingAnchor, constant: -6),
            stackViewForDates.centerYAnchor.constraint(equalTo: viewsForDates.centerYAnchor),
            
            
            
            
//            labelForDates.bottomAnchor.constraint(equalTo: viewsForDates.bottomAnchor),
//            labelForDates.topAnchor.constraint(equalTo: viewsForDates.topAnchor),
//            labelForDates.leadingAnchor.constraint(equalTo: viewsForDates.leadingAnchor),
//            labelForDates.trailingAnchor.constraint(equalTo: viewsForDates.trailingAnchor),
        ])
    }
    
    // MARK: - Colapsed UI
    
    func setUpUIIfIsColapsed(){
        
    }
    
    func constraintsIfIsColapsed(){
        
    }
    
}



#Preview {
    DownProjectColapsedView()
}

class ColapsedView: UIView {
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TopProjectColapsedAndExpandedView: UIView {
    let icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    let title: LabelComponent = {
        let label = LabelComponent(text: "Mini 02 - Bem Social", accessibilityLabel: "Mini 02 - Bem Social")
        return label
    }()
    let buttonToOpen: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    let stackViewForTop: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 11, left: 20, bottom: 11, right: 16)
        return stackView
    }()
    let stackViewForIconAndTitle: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    init(font: UIFont = UIFont.systemFont(ofSize: 15), text: String = "Blank", textColor: UIColor = .white, backgroundColor: UIColor = .systemGray2){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        icon.image = UIImage(systemName: "star.fill")
        setUpUI()
        addAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        addSubview(stackViewForTop)
        stackViewForTop.addArrangedSubview(stackViewForIconAndTitle)
        stackViewForTop.addArrangedSubview(buttonToOpen)
        stackViewForIconAndTitle.addArrangedSubview(icon)
        stackViewForIconAndTitle.addArrangedSubview(title)
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            stackViewForTop.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewForTop.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewForTop.topAnchor.constraint(equalTo: topAnchor),
            stackViewForTop.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

class DownProjectColapsedView: UIView {
    
    let stackViewForDown: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 11, left: 15, bottom: 11, right: 16.5)
        return stackView
    }()
    
    let stackViewForPercent: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = -13
        return stackView
    }()
    
    let percentLabel: LabelComponent = {
        let label = LabelComponent(text: "50%", accessibilityLabel: "Porcentagem do projeto", font: UIFont.TextStyle.extraLargeTitle)
        return label
    }()
    
    let percentLabel2: LabelComponent = {
        let label = LabelComponent(text: "de progresso", accessibilityLabel: "Porcentagem do projeto", font: .caption1)
        return label
    }()
    
    init(font: UIFont = UIFont.systemFont(ofSize: 15), text: String = "Blank", textColor: UIColor = .white, backgroundColor: UIColor = .systemGray2){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        setUpUI()
        addAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        addSubview(stackViewForDown)
        stackViewForDown.addArrangedSubview(stackViewForPercent)
        stackViewForPercent.addArrangedSubview(percentLabel)
        stackViewForPercent.addArrangedSubview(percentLabel2)
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            stackViewForDown.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewForDown.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewForDown.topAnchor.constraint(equalTo: topAnchor),
            stackViewForDown.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

class CustomProgressBarView: UIView {
    
    var progress: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let progressView = UIView()
        progressView.backgroundColor = UIColor.blue
        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.topAnchor.constraint(equalTo: topAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: progress)
        ])
        
    }
}

#Preview{
    CustomProgressBarView()
}
