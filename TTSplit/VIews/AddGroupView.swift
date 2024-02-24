//
//  AddGroupView.swift
//  TTSplit
//
//  Created by YTong on 2024/2/19.
//

import Foundation
import SwiftUI

//struct AddGroupView: View {
//    @ObservedObject var userViewModel = UserViewModel() // Assumes this fetches users
//    @Environment(\.dismiss) var dismiss
//    var onAddGroup: (String, [String]) -> Void
//    
//    @State private var selectedUserIDs: Set<String> = []
//    @State private var groupName: String = ""
//
//    var body: some View {
//        NavigationView {
//            Form {
//                TextField("Group Name", text: $groupName)
//                    .padding()
//                
//                List(userViewModel.users, id: \.id, selection: $selectedUserIDs) { user in
//                    Text(user.id)
//                }
//                .navigationTitle("Select Users")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button("Cancel") {
//                            dismiss()
//                        }
//                    }
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button("Done") {
//                            onAddGroup(groupName, Array(selectedUserIDs))
//                            dismiss()
//                        }
//                    }
//                }
//                
//            }
//        }
//        .onAppear {
//            userViewModel.fetchUsers()
//        }
//    }
//}


struct AddGroupView: View {
    @ObservedObject var userViewModel = UserViewModel() // Assume this exists and fetches users
    @Environment(\.presentationMode) var presentationMode
    var onAddGroup: (String, [String]) -> Void
    
    @State private var selectedUserIDs = Set<String>()
    @State private var groupName = ""

    var body: some View {
        NavigationView {
            List(userViewModel.users, id: \.id, selection: $selectedUserIDs) { user in
                Text(user.id)
            }
            .navigationBarTitle(Text("Create Group"), displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Add") {
                    // Handle adding group logic here
                    onAddGroup(groupName, Array(selectedUserIDs))
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .toolbar {
                // Group Name TextField within Toolbar for visibility
                ToolbarItem(placement: .principal) {
                    TextField("Group Name", text: $groupName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 200)
                }
            }
        }
        .onAppear {
            userViewModel.fetchUsers() // Make sure your UserViewModel is ready to fetch users
        }
    }
}

// Assuming UserViewModel is defined elsewhere
// Make sure to implement fetchUsers() to populate the users array


#Preview {
    AddGroupView(onAddGroup: { groupName, memberIDs in
        // Handle the new group creation here for preview purposes
        print("Group Name: \(groupName)")
        print("Selected Member IDs: \(memberIDs)")
    })
}
