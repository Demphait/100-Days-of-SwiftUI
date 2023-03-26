//
//  HabitSection.swift
//  HabitTracker
//
//  Created by Bohdan Plastun on 22.03.2023.
//

import SwiftUI

struct HabitSection: View {
    let title: String
    let habits: [HabitItem]
    let generalHabits: Habits
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section(header: habits.isEmpty ? nil : Text(title).foregroundColor(title == "Positive" ? .green : .red)) {
            ForEach(habits) { habit in
                NavigationLink {
                    HabitView(habits: generalHabits, habit: habit)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.headline)
                            Text("Proress: \(habit.count) / \(habit.goal)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Description: \(habit.description)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}

struct HabitSection_Previews: PreviewProvider {
    static var previews: some View {
        HabitSection(title: "Example", habits: [], generalHabits: Habits(), deleteItems: { _ in })
    }
}
