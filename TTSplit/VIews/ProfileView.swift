//
//  ProfileView.swift
//  TTSplit
//
//  Created by YTong on 2024/2/20.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        Button("Log out") {
            Task {
                do {
                    try viewModel.logOut()
                    showSignInView = true
                } catch {
                    print(error)
                }
            }
        }
        .navigationBarTitle("Profile")
    }
}

#Preview {
    ProfileView(showSignInView: .constant(false))
}
