//
//  ContentView.swift
//  TTSplit
//
//  Created by YTong on 2024/2/18.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @StateObject private var viewModel = GroupViewModel()
    @State private var isUserLoggedIn = false

    var body: some View {
        NavigationView {
            if isUserLoggedIn {
                GroupListView(viewModel: viewModel)
            } else {
                LoginView(loginCompletion: handleLogin)
            }
        }
        .onAppear {
            // Set up the authentication state did change listener
            self.listenToAuthenticationState()
        }
    }

    private func listenToAuthenticationState() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.isUserLoggedIn = true
            } else {
                self.isUserLoggedIn = false
            }
        }
    }
    
    private func handleLogin() {
        self.isUserLoggedIn = true
    }
}

#Preview {
    MainView()
}
