//
//  ExpenseModel.swift
//  TTSplit
//
//  Created by YTong on 2024/2/18.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id: String // Firestore document ID
    var description: String
    var amount: Double
    var paidBy: String // User ID of who paid
    var splits: [String: Double] // Dictionary of user IDs and the amount they owe
}
