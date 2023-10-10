//
//  SegmentedControl.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 27/09/23.
//

import UIKit

/// A custom segmented control for selecting task priorities.
///
/// `SegmentedControl` is a subclass of `UISegmentedControl` designed for choosing task
/// priorities. It provides segmented options for "No Priority," "Low," "Medium," and "High."
///
/// ## Usage
///
/// To use `SegmentedControl`, create an instance and configure it as needed.
///
/// ```swift
/// let prioritySegmentedControl = SegmentedControl()
///
/// // Access the selected priority
/// let selectedPriority = prioritySegmentedControl.priority
/// ```
/// - Note: `SegmentedControl` provides a user-friendly way to select task priorities and
///         can be integrated into task management interfaces.
///
/// - SeeAlso: `UISegmentedControl`
class SegmentedControl: UISegmentedControl {
    
    let feedback = UISelectionFeedbackGenerator()
    
    /// The selected task priority as a string.
    var priority: String?
    
    /// Initializes a `SegmentedControl` instance with priority segments.
    ///
    /// The segmented control is initialized with priority options: "No Priority,"
    /// "Low," "Medium," and "High." The default selected segment is the first one
    /// (No Priority).
    init() {
        super.init(items: [
            String(localized: "NoPriorityKey"),
            String(localized: "LowKey"),
            String(localized: "MediumKey"),
            String(localized: "HighKey")
        ])
        self.backgroundColor = UIColor.clear
        
        createSegments()
        
        // Set the default selected segment to the first one
        self.selectedSegmentIndex = 0
        // Call the target action manually to update the 'priority' property
      eachSegment(self)
        feedback.prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
  func indexForPriority(_ priority: String) -> Int? {
      switch priority {
      case Priority.noPriority.rawValue:
          return 0
      case Priority.low.rawValue:
          return 1
      case Priority.medium.rawValue:
          return 2
      case Priority.high.rawValue:
          return 3
      default:
          return nil
      }
  }

    
    /// Creates the segmented control segments and sets up the target action.
    private func createSegments() {
        self.addTarget(self, action: #selector(eachSegment), for: .valueChanged)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Updates the selected priority based on the segmented control's selection.
    ///
    /// - Parameter segmentedControl: The segmented control whose value changed.
    @objc private func eachSegment(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
          self.priority = Priority.noPriority.rawValue
            self.feedback.selectionChanged()
        case 1:
          self.priority = Priority.low.rawValue
            self.feedback.selectionChanged()
        case 2:
          self.priority = Priority.medium.rawValue
            self.feedback.selectionChanged()
        case 3:
          self.priority = Priority.high.rawValue
            self.feedback.selectionChanged()
        default:
          self.priority = nil
            self.feedback.selectionChanged()
        }
    }
}

#Preview {
  SegmentedControl()
}
