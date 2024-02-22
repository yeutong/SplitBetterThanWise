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
    @State private var showingAddGroupView = false  // State to control the presentation of the add group view
    
    var body: some View {
        List(viewModel.groups) { group in
            Text(group.name)
        }
        .navigationBarTitle("My Groups")
        .navigationBarItems(trailing: addButton)  // Add a navigation bar item
        .onAppear {
            viewModel.fetchGroups()
        }
        .sheet(isPresented: $showingAddGroupView) {
            // Present AddGroupView as a modal sheet
            AddGroupView { groupName in
                // Handle the new group name
                self.viewModel.addGroup(groupName: groupName)
                self.showingAddGroupView = false
            }
        }
    }
    
    private var addButton: some View {
        Button(action: {
            self.showingAddGroupView = true
        }) {
            Image(systemName: "plus")
        }
    }
}
