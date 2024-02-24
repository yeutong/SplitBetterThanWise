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
    
    private func addExpense() {
        guard let amount = Int(expenseAmount) else {
            print("\(expenseAmount)")
            print("Invalid amount")
            return
        } // Ensure we have a valid amount before proceeding
        
        guard !expenseDescription.isEmpty else {
            print("empty description")
            return
        }
        print("Im here")
        let db = Firestore.firestore()
        let expenseRef = db.collection("expenses").document()
        let newExpense = Expense(
            id: expenseRef.documentID,
            groupId: group.id,
            description: expenseDescription,
            amount: amount
//            paidBy: "",
//            splits: ["": 0]
        ) // Assuming Expense is Codable and has these properties

        do {
            try expenseRef.setData(from: newExpense)
            expenseDescription = "" // Reset the fields after submission
            expenseAmount = ""
            fetchExpenses()
        } catch let error {
            print("Error adding document: \(error)")
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

                // Form for adding new expenses
                Form {
                    TextField("Description", text: $expenseDescription)
                    TextField("Amount", text: $expenseAmount)
                    Button("Add Expense") {
                        addExpense()
                    }
                }
            }
            .navigationTitle("Expenses in \(group.name)")
            .onAppear {
                fetchExpenses()
                print("\(group.name)")
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
