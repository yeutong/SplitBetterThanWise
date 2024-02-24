//
//  UserViewModel.swift
//  TTSplit
//
//  Created by YTong on 2024/2/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var users = [User]()

    private var db = Firestore.firestore()

    func fetchUsers() {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting users: \(error.localizedDescription)")
                return
            }

            self.users = querySnapshot?.documents.compactMap { document -> User? in
                try? document.data(as: User.self)
            } ?? []
        }
    }
}
