//
//  AddExpenseViewModel.swift
//  TTSplit
//
//  Created by YTong on 2024/2/26.
//

import Foundation
import FirebaseFirestore

class AddExpenseViewModel: ObservableObject {
    @Published var expenseDescription: String = ""
    @Published var expenseAmount: String = ""
    var groupId: String?
    
    func addExpense(completion: @escaping (Bool) -> Void) {
        guard let groupId = self.groupId, let amount = Int(expenseAmount), !expenseDescription.isEmpty else {
            return
        }

        
        let db = Firestore.firestore()
        let expenseRef = db.collection("expenses").document()
        let newExpense = Expense(
            id: expenseRef.documentID,
            groupId: groupId,
            description: expenseDescription,
            amount: amount
        )
        
        do {
            try expenseRef.setData(from: newExpense)
            self.expenseDescription = ""
            self.expenseAmount = ""
            print("success adding expense")
            completion(true)
        } catch {
            print("Error adding expense: \(error)")
            completion(false)
        }
    }
}
