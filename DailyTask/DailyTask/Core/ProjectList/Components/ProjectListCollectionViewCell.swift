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
