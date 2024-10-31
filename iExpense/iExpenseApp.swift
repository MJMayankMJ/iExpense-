//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Mayank Jangid on 9/7/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
