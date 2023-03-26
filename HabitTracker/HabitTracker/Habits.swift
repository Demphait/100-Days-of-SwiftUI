//
//  Habits.swift
//  HabitTracker
//
//  Created by Bohdan Plastun on 21.03.2023.
//

import Foundation

class Habits: ObservableObject {
    @Published var items = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var positiveHabits: [HabitItem] {
        items.filter { $0.type == "Positive" }
    }
    
    var negativeHabits: [HabitItem] {
        items.filter { $0.type == "Negative" }
    }
    
    func updateHabitCount(habit: HabitItem) {
        guard let index = items.firstIndex(where: { $0.id == habit.id }) else { return }
        
        items[index].count += 1
        items[index].trackingDates.insert(Date.now, at: 0)
    }
    
    func deleteTrackingDate(habit: HabitItem, at offsets: IndexSet) {
        guard let index = items.firstIndex(where: { $0.id == habit.id }) else { return }
        
        items[index].trackingDatesFormatted.remove(atOffsets: offsets)
        items[index].count -= 1
        if (items[index].count <= 0) {
            items[index].count = 0
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
