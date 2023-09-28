//
//  DatePickerComponent.swift
//  DailyTask
//
//  Created by Eduardo on 23/09/23.
//

import UIKit

class DatePickerComponent: UIView  {
    
    var valueChangedHandler: Date?
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.minimumDate = .now
        datePicker.locale = .current
        datePicker.minuteInterval = 5
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.isUserInteractionEnabled = true

        return datePicker
    }()
    
    init(datePickerStyle: UIDatePickerStyle = .automatic, datePickerMode: UIDatePicker.Mode = .dateAndTime) {
        super.init(frame: .zero)
        datePicker.datePickerMode = datePickerMode
        datePicker.preferredDatePickerStyle = datePickerStyle
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        self.isUserInteractionEnabled = true
        self.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
