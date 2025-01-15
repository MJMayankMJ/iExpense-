//
//  SectionView.swift
//  iExpense
//
//  Created by Mayank Jangid on 10/31/24.
//

import SwiftData
import SwiftUI

struct SectionView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    var body: some View {
        ForEach(expenses) { item in
                HStack{
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.type)
                    }
                Spacer()
                Text(item.amount, format: .currency(code: "USD"))
                }
                .accessibilityElement()
                .accessibility(label: Text("\(item.name) : \(item.amount)"))
                .accessibilityHint(item.type)
                .mealExpenseDesign(cost: item.amount)
            
        }
        .onDelete(perform: removeItem)
    }
    func removeItem(at offset : IndexSet){
        for index in offset {
            modelContext.delete(expenses[index])
        }
    }
    
    init(sortOrder: [SortDescriptor<ExpenseItem>], type: String) {
            _expenses = Query(filter: #Predicate<ExpenseItem> {expense in
                expense.type == type
            }, sort: sortOrder)
        }
}

#Preview {
    let sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount),
    ]
    SectionView(sortOrder: sortOrder, type: "Personal")
}
