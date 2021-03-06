//
//  Comment.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//

import Foundation

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let comment: String
    let user: UserData
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias Comments = [Comment]
