//
//  ErrorDetail.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/04.
//

import Foundation

struct ErrorDetail: Codable {
    let statusCode: Int
    let error: String
    let message: String
}

// MARK: - Datum
struct Datum: Codable {
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let id, message: String
}

enum ErrorMessage: String {
    case invalidIdPassword = "아디디와 비밀번호를 확인해주세요."
    
}
