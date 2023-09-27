//
//  SegmentedControl.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 27/09/23.
//

import Foundation
import UIKit

class SegmentedControl: UISegmentedControl {
  
  var dates: [TimeInterval] = []
  
  var dateIsSelected: Bool?
  
  init(items: [String]) {
    super.init(items: items)
    createSuitSegments()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func createSuitSegments() {
    self.addTarget(self, action: #selector(eachSuit), for: .valueChanged)
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  @objc func eachSuit(_ segmentedControl: UISegmentedControl) -> TimeInterval {
    switch segmentedControl.selectedSegmentIndex {
    case 0:
     
      self.dateIsSelected = true
      return TimeInterval()
    case 1:
      let minutesToAdd: TimeInterval = 5 * 60 // 5 minutes in seconds
      
//          let date = Date().addingTimeInterval(minutesToAdd)
//      let dateFormatter = DateFormatter()
//      dateFormatter.locale = .current
//      dateFormatter.timeStyle = .short
//
//      let dateOk =  dateFormatter.string(from: date)
      
      self.dateIsSelected = true
      
      self.dates.append(minutesToAdd)
      //print(minutesToAdd)
      return minutesToAdd
      
    case 2:
      let minutesToAdd: TimeInterval = 15 * 60
      self.dates.append(minutesToAdd)
      
      self.dateIsSelected = true
      
      return minutesToAdd
      
    case 3:
      let minutesToAdd: TimeInterval = 30 * 60
      self.dates.append(minutesToAdd)
      
      self.dateIsSelected = true
      
      return minutesToAdd
      
    default:
    
      return TimeInterval()
      
    }
  }
  
}


#Preview{
  SegmentedControl(items: ["indefinido", "5 min", "15 min", "30 min", "1h"])
}
