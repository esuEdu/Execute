//
//  GridCollectionView.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 06/10/23.
//

import UIKit

class CustomCellCollectionView: UICollectionViewCell {
  
  let tasksComponent: AllTaskListComponts = {
    let tasks = AllTaskListComponts(titleTask: "teste", timeLabel: "amanha")
    tasks.translatesAutoresizingMaskIntoConstraints = false
    return tasks
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.addSubview(tasksComponent)
    
    NSLayoutConstraint.activate([
      tasksComponent.topAnchor.constraint(equalTo: contentView.topAnchor),
      tasksComponent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      tasksComponent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      tasksComponent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
