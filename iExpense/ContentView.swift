//
//  ContentView.swift
//  iExpense
//
//  Created by Mayank Jangid on 9/7/24.
//

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

struct ExpenseItem: Identifiable, Codable{
    //Identifiable is there so to uniquely identify each ExpenseItem (also now we can remove id: \.id in ForEach loop
    //Codable allows u to archive  and unarchiver through encode and decode.....
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expense {
    var items = [ExpenseItem]() {
        //to decode -- we first encode than save it on the phone
        // to encode -- first we get the data from storage and than decode the data and than show it...
        didSet{
            if let encodedItems = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encodedItems, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    
    @State private var expenses = Expense()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(expenses.items) { item in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                    .mealExpenseDesign(cost: item.amount)
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button("Add Items", systemImage: "plus"){
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    func removeItem(at offset : IndexSet){
        expenses.items.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
