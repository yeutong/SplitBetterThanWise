//
//  GroupViewModel.swift
//  TTSplit
//
//  Created by YTong on 2024/2/18.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class GroupViewModel: ObservableObject {
    @Published var groups = [Group]()
    
    private var db = Firestore.firestore()
    
    func fetchGroups() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No user found.")
            return
        }
        
        db.collection("groups")
            .whereField("members", arrayContains: userId)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error getting groups: \(error.localizedDescription)")
                    return
                }
                
                self.groups = querySnapshot?.documents.compactMap { document -> Group? in
                    try? document.data(as: Group.self)
                } ?? []
            }
    }
    
    func addGroup(groupName: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        let groupRef = db.collection("groups").document() // Create a new document reference
        
        // Create a group with the current user as the initial member
        let newGroup = Group(id: groupRef.documentID, name: groupName, members: [userId])
        
        // Convert the new group to a dictionary or use Codable to encode it
        do {
            try groupRef.setData(from: newGroup)
            fetchGroups() // Refresh the groups list after adding the new group
        } catch let error {
            print("Error adding group: \(error)")
        }
    }
}

