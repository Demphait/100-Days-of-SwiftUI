//
//  HabitItem.swift
//  HabitTracker
//
//  Created by Bohdan Plastun on 21.03.2023.
//

import Foundation

struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    let type: String
    var goal: Int
    var count: Int = 0
    var startDate: Date = Date.now
    var trackingDates = [Date]()
    
    var startDateFormatted: String {
        startDate.formatted(date: .abbreviated, time: .standard)
    }
    
    var trackingDatesFormatted: [String] {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
            
            return trackingDates.map {dateFormatter.string(from: $0)}
        }
        
        set {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy, h:mm a"
            
            trackingDates = newValue.compactMap { dateFormatter.date(from: $0) }
        }
    }
}
