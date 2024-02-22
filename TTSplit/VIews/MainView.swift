//
//  ContentView.swift
//  TTSplit
//
//  Created by YTong on 2024/2/18.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        NavigationStack {
            TabView {
                GroupListView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                ProfileView(showSignInView: $showSignInView)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                LoginView(showSignInView: $showSignInView)
            }
        }
    }


}

#Preview {
    MainView()
}
