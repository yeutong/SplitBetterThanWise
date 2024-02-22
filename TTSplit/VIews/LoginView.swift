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
    
    @StateObject private var viewModel = LoginViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            VStack (spacing: 20) {
                Text("Welcome")
                    .foregroundColor(Color(white: 0.4745))
                    .bold()
                    .font(.largeTitle)
                    .offset(x: -100, y: -100)
                
                TextField("Your Email", text: $viewModel.email)
                    .foregroundColor(.black)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 20)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
                SecureField("Your Password", text: $viewModel.password)
                    .foregroundColor(.black)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 20)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.black)
                
                Button {
                    Task {
                        do {
                            try await viewModel.signUp()
                            showSignInView = false
                            return
                        } catch {
                            print(error)
                        }
                    }
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
                    Task {
                        do {
                            try await viewModel.signIn()
                            showSignInView = false
                            return
                        } catch {
                            print(error)
                        }
                    }
                    
                } label: {
                    Text("Already have an account? Login")
                        .bold()
                }
                .padding(.top)
                .offset(y: 100)
                
                Button {
                    Task {
                        do {
                            try viewModel.logout()
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Logout")
                }
                .offset(y: 100)
            }
        }
    }
}


#Preview {
    LoginView(showSignInView: .constant(true))
}
