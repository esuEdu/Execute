//
//  TaskTableForProjectList.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 25/09/23.
//

import UIKit

class TaskTableForProjectList: UITableViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Texto generico"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUIIfIsExpanded(){
        
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        
        ])
    }
}

#Preview {
    TaskTableForProjectList()
}
