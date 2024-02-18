//
//  UserModel.swift
//  TTSplit
//
//  Created by YTong on 2024/2/18.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String // Use the Firebase UID as the id
    var name: String
    var email: String
    var groups: [String] // Array of group IDs
}
