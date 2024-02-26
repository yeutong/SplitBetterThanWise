//
//  AddExpenseView.swift
//  TTSplit
//
//  Created by YTong on 2024/2/26.
//

import SwiftUI
import FirebaseFirestore

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    var group: Group
    @ObservedObject var viewModel = AddExpenseViewModel()
    
    var body: some View {
        Form {
            TextField("Description", text: $viewModel.expenseDescription)
            TextField("Amount", text: $viewModel.expenseAmount)
            Button("Add Expense") { 
                viewModel.addExpense { success in
                    if success {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }.onAppear {
            viewModel.groupId = group.id
        }
    }
}

//#Preview {
//    AddExpenseView()
//}
