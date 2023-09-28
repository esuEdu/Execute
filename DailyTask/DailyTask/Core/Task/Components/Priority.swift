//
//  Priority.swift
//  DailyTask
//
//  Created by Victor Hugo Pacheco Araujo on 28/09/23.
//

import Foundation

/// An enumeration representing task priorities.
///
/// `Priority` defines different priority levels for tasks, including "No Priority,"
/// "Low," "Medium," and "High." This enumeration allows you to assign a priority level
/// to tasks, helping to categorize and manage them effectively.
///
/// ## Usage
///
/// To use `Priority`, simply access its cases to represent the desired priority level.
/// For example:
///
/// ```swift
/// let taskPriority: Priority = .medium
/// ```
///
/// - Note: The `Priority` enumeration provides a clear and organized way to express
///         the importance or urgency of tasks.
///
/// - Important: Choose an appropriate priority level for your tasks to ensure effective
///              task management and prioritization.
enum Priority: String {
    /// Represents no priority.
    case noPriority = "None"
    
    /// Represents a low priority level.
    case low = "Low"
    
    /// Represents a medium priority level.
    case medium = "Medium"
    
    /// Represents a high priority level.
    case high = "High"
}
