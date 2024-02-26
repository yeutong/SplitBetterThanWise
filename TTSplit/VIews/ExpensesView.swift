import SwiftUI
import FirebaseFirestore

struct ExpensesView: View {
    var group: Group
    @State private var expenses: [Expense] = []
    @State private var expenseDescription: String = ""
    @State private var expenseAmount: String = "" // Using optional Int to handle empty or invalid inputs gracefully

    private func fetchExpenses() {
        let db = Firestore.firestore()
        db.collection("expenses")
            .whereField("groupId", isEqualTo: group.id) // Assuming each expense has a 'groupId' field
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.expenses = querySnapshot.documents.compactMap { document -> Expense? in
                        try? document.data(as: Expense.self)
                    }
                }
            }
    }
    

        
    var body: some View {
        NavigationStack {
            VStack {
                List(expenses) { expense in
                   VStack(alignment: .leading) {
                       Text(expense.description)
                           .font(.headline)
                       Text("Amount: \(expense.amount)")
                           .font(.subheadline)
                       Text("Paid by: \(expense.paidBy)")
                           .font(.subheadline)
                   }
                }
                .navigationTitle("Expenses in \(group.name)")
                .toolbar {
                    NavigationLink(destination: AddExpenseView(group: group)) {
                        Text("Add Expense")
                    }
                }
            }
            .onAppear {
                fetchExpenses()
            }
        }
    }

}

#Preview {
    ExpensesView(group: Group(
        id: "3Bswy5HlaZw0zyClFWOs",
        name: "Hi2",
        members: [
            "I5A6EOVVa2dATZsIdyAlGAVZSk43",
            "GW5lL8dSQ8PBqUcx5vIOljb32fx2"
        ]
    ))
}
