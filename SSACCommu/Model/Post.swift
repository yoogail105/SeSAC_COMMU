//
//  Post.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//


import Foundation

// MARK: - Post
struct Post: Codable {
    let id: Int
    let text: String
    let user: UserData
    let createdAt, updatedAt: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
