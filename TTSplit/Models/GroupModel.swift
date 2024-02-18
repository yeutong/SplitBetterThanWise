//
//  GroupModel.swift
//  TTSplit
//
//  Created by YTong on 2024/2/18.
//

import Foundation

struct Group: Identifiable, Codable {
    var id: String // Firestore document ID
    var name: String
    var members: [String] // Array of user IDs
}
