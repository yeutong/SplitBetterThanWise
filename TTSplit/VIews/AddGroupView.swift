//
//  AddGroupView.swift
//  TTSplit
//
//  Created by YTong on 2024/2/19.
//

import Foundation
import SwiftUI

struct AddGroupView: View {
    @State private var groupName = ""
    var addGroupCompletion: (String) -> Void  // Closure to handle adding a group
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Group Name", text: $groupName)
                
                Button("Add Group") {
                    // Call the completion closure with the new group name
                    addGroupCompletion(groupName)
                }
            }
            .navigationBarTitle("Add Group", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                // Dismiss the view without adding a group
                addGroupCompletion("")
            })
        }
    }
}

