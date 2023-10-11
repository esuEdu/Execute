//
//  DatePickerComponent.swift
//  DailyTask
//
//  Created by Eduardo on 23/09/23.
//

import UIKit

class DatePickerComponent: UIDatePicker  {
 
    init(datePickerStyle: UIDatePickerStyle = .automatic, datePickerMode: UIDatePicker.Mode = .dateAndTime, maxDate: Date? = nil) {
        super.init(frame: .zero)
        self.datePickerMode = datePickerMode
        self.preferredDatePickerStyle = datePickerStyle
        self.isUserInteractionEnabled = true
        self.minimumDate = .now
        if maxDate != nil {
            self.maximumDate = maxDate
        }
        self.locale = .current
        self.minuteInterval = 5
        self.timeZone = .current
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
  let datePickerController = DatePickerView<Date>()
 datePickerController.datePickerMode = .time
 datePickerController.valueChangedHandler = { selectedDate in
      print("Selected Time: \(selectedDate)")
 }
  return datePickerController
}
