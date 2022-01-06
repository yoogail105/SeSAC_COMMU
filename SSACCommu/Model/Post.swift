//
//  Post.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//


import Foundation

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


typealias Posts = [Post]
