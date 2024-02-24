//
//  GroupListView.swift
//  TTSplit
//
//  Created by YTong on 2024/2/18.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore


struct GroupListView: View {
    @ObservedObject var viewModel = GroupViewModel()
    @State private var showingAddGroupView = false
    
    var body: some View {
        NavigationStack {
            List(viewModel.groups) { group in
                NavigationLink(destination: ExpensesView(group: group)) {
                    Text(group.name)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { addButton }
            }
            .onAppear(perform: viewModel.fetchGroups)
            .sheet(isPresented: $showingAddGroupView) {
                AddGroupView { groupName, memberIDs in
                    viewModel.addGroup(groupName: groupName, memberIDs: memberIDs)
                    showingAddGroupView = false
                }
            }
            .navigationTitle("My Groups")
        }
    }
    
    private var addButton: some View {
        Button(action: {
            showingAddGroupView = true
        }) {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    GroupListView()
}
