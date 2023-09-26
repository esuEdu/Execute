//
//  DatePickerComponent.swift
//  DailyTask
//
//  Created by Eduardo on 23/09/23.
//

import UIKit

enum DatePickerMode {
    case date
    case time
    case dateAndTime
}

/// A custom date picker view for selecting date and time values.
///
/// `DatePickerView` is a subclass of `UIDatePicker` that provides additional customization
/// and value change handling.
///
/// ## Usage
///
/// To use `DatePickerView`, create an instance and configure it as needed. You can set the
/// display mode using the `selectedMode` property and handle value changes with the
/// `valueChangedHandler` closure.
///
/// ```swift
/// let datePickerController = DatePickerView<Date>()
/// datePickerController.datePickerMode = .dateAndTime
/// datePickerController.valueChangedHandler = { selectedDate in
///     print("Selected Time: \(selectedDate)")
/// }
/// ```
///
/// - Note: `DatePickerView` supports various display modes, including date-only, time-only,
///         and date and time combined.
///
/// - Important: When the `selectedValue` property changes, the `valueChangedHandler` closure
///              is called, allowing you to react to the selected value.
///
/// - SeeAlso: `UIDatePicker`
class DatePickerView<T>: UIDatePicker {
    
    /// variable of datePicker timer
    var valueChangedHandler: ((T) -> Void)?
    
    private var selectedMode: DatePickerMode = .date {
        didSet {
            switch selectedMode {
            case .date:
                datePickerMode = .date
                dateFormat = "yyyy-MM-dd"
            case .time:
                datePickerMode = .time
                dateFormat = "HH:mm"
            case .dateAndTime:
                datePickerMode = .dateAndTime
                dateFormat = "yyyy-MM-dd HH:mm"
            }
        }
    }
    
    
    private var dateFormat = "yyyy-MM-dd" // Default to date format
    // A property to store the selected value
    var selectedValue: T? {
        didSet {
            if let selectedValue = selectedValue {
                valueChangedHandler?(selectedValue)
                minuteInterval = 5
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        preferredDatePickerStyle = .compact
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func datePickerValueChanged() {
        // Handle the date picker value change and cast it to the generic type
        if let value = self.date as? T {
            selectedValue = value
        }
    }
}

#Preview("DatePicker",traits: .sizeThatFitsLayout, body: {
    
    let datePickerController = DatePickerView <Date>()
    datePickerController.datePickerMode = .time
    datePickerController.valueChangedHandler = { selectedDate in
        print("Selected Time: \(selectedDate)")
    }
    return datePickerController
})
