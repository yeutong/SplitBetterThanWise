//
//  LoginViewModel.swift
//  TTSplit
//
//  Created by YTong on 2024/2/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        let user = try await AuthenticationManager.shared.createUser(email: email, password: password)
        try AuthenticationManager.shared.createUserInFirestore(user: user)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
    func logout() throws {
        try AuthenticationManager.shared.signOut()
    }
    

}
