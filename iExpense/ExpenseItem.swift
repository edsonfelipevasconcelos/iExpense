//
//  ExpenseItem.swift
//  iExpense
//
//  Created by EDSON FELIPE VASCONCELOS on 24/04/23.
//

import Foundation


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var currency: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    init() {
        if let saveItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: saveItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
