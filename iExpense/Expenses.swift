//
//  Expenses.swift
//  iExpense
//
//  Created by Bohdan Plastun on 11.03.2023.
//

import Foundation

class Expenses: ObservableObject {    
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    func sortExpense(_ arrayOfBusiness: inout [ExpenseItem], _ arrayOfPersonal: inout [ExpenseItem]) {
        for expense in self.items {
            if expense.type == "Business" {
                arrayOfBusiness.append(expense)
            } else if expense.type == "Personal" {
                arrayOfPersonal.append(expense)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
