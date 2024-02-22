//
//  File.swift
//  TTSplit
//
//  Created by YTong on 2024/2/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    func getAuthenticatedUser() throws -> User {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return User(id: user.uid, email: user.email)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> User {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return User(id: authDataResult.user.uid, email: authDataResult.user.email)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> User {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return User(id: authDataResult.user.uid, email: authDataResult.user.email)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func createUserInFirestore(user: User) throws {
        let db = Firestore.firestore()
        try db.collection("users").document(user.id).setData(from: user)
    }
}
