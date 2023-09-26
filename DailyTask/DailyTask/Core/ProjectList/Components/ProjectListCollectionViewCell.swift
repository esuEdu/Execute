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
    ProjectListCollectionViewCell()
}
