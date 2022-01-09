//
//  User.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/04.
//

import Foundation

// MARK: Info
struct  User: Codable {
    var jwt: String
    var user: UserData
}

// MARK: User
// CodingKeys에 struct 내에 선언된 모든 멤버가 들어가지 않으면 오류: 'Type '~~~' does not conform to protocol 'decodable/encodable'

struct UserData: Codable {
    var id: Int
    var username, email: String
    var createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, username, email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
