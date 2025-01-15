//
//  ContentView.swift
//  iExpense
//
//  Created by Mayank Jangid on 9/7/24.
//

import SwiftData
import SwiftUI

struct MealExpenseDesign: ViewModifier{
    let cost: Double
    func body(content: Content) -> some View {
        if cost < 10 {
            content
                .foregroundStyle(.green)
        }
        else if cost >= 10 && cost < 100 {
            content
                .foregroundStyle(.cyan)
        }
        else{
            content
                .foregroundStyle(.red)
        }
    }
}

extension View{
    func mealExpenseDesign(cost: Double) -> some View{
        self.modifier(MealExpenseDesign(cost: cost))
    }
}

struct ContentView: View {
    
    @State private var showingAddExpense = false
    @State private var showBusinessExpenses = false
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount),
    ]
    
    @Query var expenses: [ExpenseItem]
    
    var body: some View {
        NavigationStack {
            List{
                SectionView(sortOrder: sortOrder, type: showBusinessExpenses ? "Business" : "Personal")
            }
            .navigationTitle("iExpense")
            .toolbar{
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: AddView()) {
                        Image(systemName :"plus")
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount),
                                ])
                            
                            Text("Sort by amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name),
                                ])
                            
                            
                        } //Picker
                    } //Menu
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button(showBusinessExpenses ? "Show Personal" : "Show Business") {
                        showBusinessExpenses.toggle()
                    }
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
