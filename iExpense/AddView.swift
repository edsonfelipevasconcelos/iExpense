//
//  AddView.swift
//  iExpense
//
//  Created by EDSON FELIPE VASCONCELOS on 24/04/23.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0

    let types = ["Business", "Personal"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: expenses.currency)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarItems(
                leading: Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }) {
                    Text("Save")
                }
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
