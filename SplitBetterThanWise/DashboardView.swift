//
//  DashboardView.swift
//  SplitBetterThanWise
//
//  Created by YTong on 2023/11/27.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            List {
                // Here you can list the expenses and balances
                Text("Expense 1")
                Text("Expense 2")
                //...
            }
            .navigationTitle("Dashboard")
            .navigationBarItems(trailing:
                NavigationLink(destination: AddExpenseView()) {
                    Text("Add Expense")
                }
            )
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

