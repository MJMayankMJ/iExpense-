//
//  AddView.swift
//  iExpense
//
//  Created by Mayank Jangid on 9/9/24.
//

import SwiftData
import SwiftUI

struct AddView: View{
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = "Title"
    @State private var type = ""
    @State private var amount = 0.0
    
    //@Query var expenses: [ExpenseItem]
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add expense")
            //.navigationBarTitleDisplayMode(.inline) - i hated this methodEating you
            .toolbar{
                Button("Save"){
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    modelContext.insert(item)
                    dismiss()
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddView()
}
