//
//  LoginView.swift
//  TTSplit
//
//  Created by YTong on 2024/2/18.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    var loginCompletion: () -> Void
    
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            VStack (spacing: 20) {
                Text("Welcome")
                    .foregroundColor(Color(white: 0.4745))
                    .bold()
                    .font(.largeTitle)
                    .offset(x: -100, y: -100)
                
                TextField("Your Email", text: $email)
                    .foregroundColor(.black)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 20)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
                SecureField("Your Password", text: $password)
                    .foregroundColor(.black)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 20)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
                Button {
                    register()
                } label: {
                    Text("Sign up")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(.gray)
                        )
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y:100)
                
                Button {
                    login()
                } label: {
                    Text("Already have an account? Login")
                        .bold()
                }
                .padding(.top)
                .offset(y: 100)
                
                Button {
                    logout()
                } label: {
                    Text("Logout")
                }
                .offset(y: 100)
            }
        }
    }
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                loginCompletion()
            }
        }
    }
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else if let result = result {
                // Create a new user in the Firestore 'users' collection
                let newUser = User(id: result.user.uid, name: "", email: self.email, groups: [])
                self.createUserInFirestore(user: newUser)
                loginCompletion()
                
            }
            
        }
    }
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func createUserInFirestore(user: User) {
        let db = Firestore.firestore()
        do {
            try db.collection("users").document(user.id).setData(from: user)
        } catch let error {
            print("Error writing document: \(error)")
        }
    }
}


//#Preview {
//    LoginView(loginCompletion: {() -> Void})
//}
