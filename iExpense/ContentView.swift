//
//  ContentView.swift
//  iExpense
//
//  Created by EDSON FELIPE VASCONCELOS on 21/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var search = ""
    @State private var showingAddExpense = false
    @State private var isEditing = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                        HStack {
                            VStack {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            VStack {
                                Text(item.amount, format: expenses.currency)
                            }
                            .frame(minWidth: 100, idealWidth: 100, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .center)
                            .background {
                                if item.amount > 100 {
                                    Color.red
                                } else if item.amount >= 11 {
                                    Color.yellow
                                } else {
                                    Color.green
                                }
                            }
                            .cornerRadius(10)
                            
                        }
                    }
                    .onDelete(perform: removeItem)
                }
                Section("Business") {
                    ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                        HStack {
                            VStack {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            VStack {
                                Text(item.amount, format: expenses.currency)
                            }
                            .frame(minWidth: 100, idealWidth: 100, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .center)
                            .background {
                                if item.amount > 100 {
                                    Color.red
                                } else if item.amount >= 11 {
                                    Color.yellow
                                } else {
                                    Color.green
                                }
                            }
                            .cornerRadius(10)
                        }
                    }
                    .onDelete(perform: removeItem)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .searchable(text: $search) {
                ForEach(expenses.items.filter { $0.name.contains(search) }) { item in
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        VStack {
                            Text(item.amount, format: expenses.currency)
                        }
                        .frame(minWidth: 100, idealWidth: 100, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .center)
                        .background {
                            if item.amount > 100 {
                                Color.red
                            } else if item.amount >= 11 {
                                Color.yellow
                            } else {
                                Color.green
                            }
                        }
                        .cornerRadius(10)
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
