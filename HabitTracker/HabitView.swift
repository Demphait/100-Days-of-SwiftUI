//
//  HabitView.swift
//  HabitTracker
//
//  Created by Bohdan Plastun on 22.03.2023.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var habits: Habits
    @State var habit: HabitItem
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Text(habit.startDateFormatted)
                } header: {
                    Text("Start tracking")
                }
                
                Section {
                    Text(habit.description)
                } header: {
                    Text("Description")
                }
                
                Section {
                    HStack {
                        Text("\(habit.count) / \(habit.goal)")
                        Spacer()
                        Button("Add") {
                            self.habit.count += 1
                            self.habit.trackingDates.insert(Date.now, at: 0)
                            habits.updateHabitCount(habit: habit)
                        }
                    }
                } header: {
                    Text("Progress")
                }
                
                Section(header: habit.trackingDates.isEmpty ? nil : Text("Tracking date")) {
                    ForEach(habit.trackingDatesFormatted, id: \.self) { date in
                        Text(date)
                    }
                    .onDelete(perform: removeDate)
                }
            }
        }
        .navigationTitle(habit.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func removeDate(at offsets: IndexSet) {
        habit.trackingDates.remove(atOffsets: offsets)
        habit.count -= 1
        if(habit.count <= 0) {
            habit.count = 0
        }
        habits.deleteTrackingDate(habit: habit, at: offsets)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habits: Habits(), habit: HabitItem(name: "", description: "", type: "", goal: 0, count: 0))
    }
}
