//
//  TableViewCell.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 03/10/23.
//

import UIKit

class SubstaskInTaskTableViewCell: UITableViewCell {
    
    static let identifier = "SubtaskCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 10)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let labelSubTasks: BreakableTextComponent = {
        let label = BreakableTextComponent(placeholderColor: .systemGray2, textColor: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(view)
        self.view.addSubview(stackView)
                
        stackView.addArrangedSubview(checkbox)
        stackView.addArrangedSubview(labelSubTasks)
        stackView.addArrangedSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            checkbox.heightAnchor.constraint(equalToConstant: 30),
            checkbox.widthAnchor.constraint(equalToConstant: 29),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let checkbox = Checkbox()
    
    
    func returnText() -> String{
        return labelSubTasks.getText()
    }
    
}

#Preview{
    SubstaskInTaskTableViewCell()
}

