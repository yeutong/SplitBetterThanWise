//
//  ExpensesViewModel.swift
//  TTSplit
//
//  Created by YTong on 2024/2/26.
//

import Foundation
import FirebaseFirestore

class ExpensesViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    private var group: Group
    
    init(group: Group) {
        self.group = group
    }
    
    
    func fetchExpenses() {
        let db = Firestore.firestore()
        db.collection("expenses")
            .whereField("groupId", isEqualTo: self.group.id) // Assuming each expense has a 'groupId' field
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.expenses = querySnapshot.documents.compactMap { document -> Expense? in
                        try? document.data(as: Expense.self)
                    }
                }
            }
    }
    
    func deleteExpense(at offsets: IndexSet) {
        let db = Firestore.firestore()
        offsets.forEach { index in
            // Get the ID of the expense to delete
            let expenseId = self.expenses[index].id
            // Remove the expense from Firestore
            db.collection("expenses").document(expenseId).delete { error in
                if let error = error {
                    print("Error deleting expense: \(error)")
                } else {
                    // If you want to update the UI immediately without waiting for the listener, you can remove the expense from the array
                    self.expenses.remove(atOffsets: offsets)
                }
            }
        }
    }
    
}
