//
//  ProfileView.swift
//  TTSplit
//
//  Created by YTong on 2024/2/20.
//

import SwiftUI
import FirebaseAuth

final class ProfileViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var userID: String = ""
    
    init() {
        fetchUserDetails()
    }
    
    func fetchUserDetails() {
        if let user = Auth.auth().currentUser {
            self.userName = user.displayName ?? "No Name"
            self.userID = user.uid
        }
    }
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome, \(viewModel.userName)")
                        .font(.headline)
                    Text("User ID: \(viewModel.userID)")
                        .font(.subheadline)
                }
                Spacer() // Pushes the content to the left
            }
            .padding([.top, .horizontal])
            
            Spacer() // Pushes everything to the top
            
            Button(action: {
                Task {
                    do {
                        try viewModel.logOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }) {
                Text("Log out")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchUserDetails()
        }
    }
}

// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(showSignInView: .constant(false))
        }
    }
}
