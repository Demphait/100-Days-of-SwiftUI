//
//  AddView.swift
//  HabitTracker
//
//  Created by Bohdan Plastun on 21.03.2023.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var description = ""
    @State private var type = "Positive"
    @State private var amount: Int? = nil
    @FocusState private var amountIsFocused: Bool
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss
    
    let types = ["Positive", "Negative"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .focused($amountIsFocused)
                } header: {
                    Text("Name")
                }
                
                Section {
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                        .focused($amountIsFocused)
                } header: {
                    Text("Description")
                }
                
                Section {
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Type")
                }
                
                Section {
                    TextField("Goal", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Goal")
                }
                
            }
            .navigationTitle("Add new habit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let item = HabitItem(name: name, description: description, type: type, goal: amount ?? 0)
                        habits.items.insert(item, at: 0)
                            dismiss()
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
