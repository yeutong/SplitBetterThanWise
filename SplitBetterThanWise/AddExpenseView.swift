//
//  AddExpenseView.swift
//  SplitBetterThanWise
//
//  Created by YTong on 2023/11/27.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var amount: String = ""
    @State private var description: String = ""
    // Add more states as needed for splitting logic

    var body: some View {
        Form {
            Section(header: Text("Expense Details")) {
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                TextField("Description", text: $description)
            }
            // Add more fields as required for specifying split details

            Button("Add Expense") {
                // Handle the addition of the expense
                // Include logic for splitting the expense here
            }
        }
        .navigationTitle("Add Expense")
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}

