//
//  Post.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//


import Foundation

struct Post: Codable {
    var id: Int
    var text: String
    var user: UserData
    var createdAt, updatedAt: String
    var comments: [PostComment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

struct PostComment: Codable {
    var id: Int
    var comment: String
    var user, post: Int
    var createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



typealias Posts = [Post]
