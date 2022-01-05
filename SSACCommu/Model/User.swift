//
//  User.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/04.
//

import Foundation

// MARK: Info
struct  User: Codable {
    let jwt: String
    let user: UserData
}

// MARK: User
// CodingKeys에 struct 내에 선언된 모든 멤버가 들어가지 않으면 오류: 'Type '~~~' does not conform to protocol 'decodable/encodable'

struct UserData: Codable {
    let id: Int
    let username, email: String
    let confirmed: Bool
    let role: Role
    let createdAt, updatedAt: String
    let posts, comments: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id, username, email, confirmed, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case posts, comments
    }
}

// MARK: Role
struct Role: Codable {
    let id: Int
    let name, roleDescription, type: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roleDescription = "description"
        case type
    }
}
