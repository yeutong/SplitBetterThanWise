//
//  ExpenseModel.swift
//  TTSplit
//
//  Created by YTong on 2024/2/18.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id: String // Firestore document ID
    var groupId: String
    var description: String
    var amount: Int
    var paidBy: String = "" // User ID of who paid
    var splits: [String: Int] = [:] // Dictionary of user IDs and the amount they owe
}


