//
//  DeadlineComponent.swift
//  DailyTask
//
//  Created by Eduardo on 28/09/23.
//

import Foundation
import UIKit

class DeadlineComponent: UIView {
    
    let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let label: LabelComponent = {
       let label = LabelComponent(text: String(localized: "Start"), accessibilityLabel: "Start")
        return label
    }()
    
    let startDatePicker: DatePickerView<Date> = {
        let datePicker = DatePickerView<Date>()
        datePicker.datePickerMode = .dateAndTime
        datePicker.valueChangedHandler = { selectedDate in
            
        }
        return datePicker
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
