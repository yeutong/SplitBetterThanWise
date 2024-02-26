import SwiftUI
import FirebaseFirestore

struct ExpensesView: View {
    var group: Group
    @ObservedObject var viewModel: ExpensesViewModel
    
    init(group: Group) {
        self.group = group
        self.viewModel = ExpensesViewModel(group: group)
    }


        
    var body: some View {
        NavigationStack {
            VStack {
                List{
                    ForEach(viewModel.expenses) { expense in
                        VStack(alignment: .leading) {
                            Text(expense.description)
                                .font(.headline)
                            Text("Amount: \(expense.amount)")
                                .font(.subheadline)
                            Text("Paid by: \(expense.paidBy)")
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: viewModel.deleteExpense)
                }
                .navigationTitle("Expenses in \(group.name)")
                .toolbar {
                    NavigationLink(destination: AddExpenseView(group: group)) {
                        Text("Add Expense")
                    }
                }
            }
            .onAppear {
                viewModel.fetchExpenses()
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
