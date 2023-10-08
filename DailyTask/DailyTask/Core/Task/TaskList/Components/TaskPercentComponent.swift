//
//  TaskPercentComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 06/10/23.
//

import UIKit

class TaskPercentComponent: UIView{

    let line: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .systemGray
        return line
    }()
    
    let labelPercent: UILabel = {
        let label = UILabel()
        label.text = "100%"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let progress: CircularProgressView = {
        let progress = CircularProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        
        return progress
    } ()
    
    init(percent: Double){
        super.init(frame: .zero)
        progress.setProgress(percent)
        addSubview(line)
        addSubview(labelPercent)
        addSubview(progress)
        addAllConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAllConstraints(){
        NSLayoutConstraint.activate([
            progress.centerXAnchor.constraint(equalTo: centerXAnchor),
            progress.topAnchor.constraint(equalTo: topAnchor),
            progress.heightAnchor.constraint(equalToConstant: labelPercent.font.lineHeight * 5),
            progress.widthAnchor.constraint(equalToConstant: labelPercent.font.lineHeight * 5),

            line.topAnchor.constraint(equalTo: progress.bottomAnchor),
            line.centerXAnchor.constraint(equalTo: progress.centerXAnchor),
            line.widthAnchor.constraint(equalTo: progress.widthAnchor, multiplier: 0.135),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            labelPercent.leadingAnchor.constraint(equalTo: progress.leadingAnchor),
            labelPercent.trailingAnchor.constraint(equalTo: progress.trailingAnchor),
            labelPercent.topAnchor.constraint(equalTo: progress.topAnchor),
            labelPercent.bottomAnchor.constraint(equalTo: progress.bottomAnchor),
            labelPercent.centerYAnchor.constraint(equalTo: progress.centerYAnchor),
            labelPercent.centerXAnchor.constraint(equalTo: progress.centerXAnchor),
        ])
    }
    
}

#Preview{
    TaskPercentComponent(percent: 0.3)
}
