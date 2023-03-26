//
//  ContentView.swift
//  HabitTracker
//
//  Created by Bohdan Plastun on 21.03.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                HabitSection(title: "Positive", habits: habits.positiveHabits, generalHabits: habits, deleteItems: removePositiveItems)
                HabitSection(title: "Negative", habits: habits.negativeHabits, generalHabits: habits, deleteItems: removeNegativeItems)
            }
            .overlay(Group {
                if habits.positiveHabits.isEmpty && habits.negativeHabits.isEmpty {
                    Text("Oops, looks like there's no data...")
                        .foregroundColor(.secondary)
                }
            })
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddHabit) {
                    AddView(habits: habits)
                }

            }
        }
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [HabitItem]) {
            var objectsToDelete = IndexSet()
            
            for offset in offsets {
                let item = inputArray[offset]
                
                if let index = habits.items.firstIndex(of: item) {
                    objectsToDelete.insert(index)
                }
            }
            
            habits.items.remove(atOffsets: objectsToDelete)
        }
        
        func removePositiveItems(at offsets: IndexSet) {
            removeItems(at: offsets, in: habits.positiveHabits)
        }
        
        func removeNegativeItems(at offsets: IndexSet) {
            removeItems(at: offsets, in: habits.negativeHabits)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
