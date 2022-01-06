//
//  UserDefaults+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys: String, CaseIterable {
        case validToken
        case token
        case id
        case nickname
        case email
        case confirmed
        case postId
    }
    
    func reset() {
        UserDefaultsKeys.allCases.forEach {
            removeObject(forKey: $0.rawValue)
        }
    }
    
    var validToken: Bool {
        get { bool(forKey: UserDefaultsKeys.validToken.rawValue)}
        set { setValue(newValue, forKey: UserDefaultsKeys.validToken.rawValue)}
    }
    
    var token: String? {
        get { string(forKey: UserDefaultsKeys.token.rawValue)}
        set { setValue(newValue, forKey: UserDefaultsKeys.token.rawValue)}
    }
    
    var id: Int {
        get { integer(forKey: UserDefaultsKeys.id.rawValue)}
        set { setValue(newValue, forKey: UserDefaultsKeys.id.rawValue)}
    }
    
    var nickname: String? {
        get { string(forKey: UserDefaultsKeys.nickname.rawValue)}
        set { setValue(newValue, forKey: UserDefaultsKeys.nickname.rawValue)}
    }
    
    var email: String? {
        get { string(forKey: UserDefaultsKeys.email.rawValue)}
        set { setValue(newValue, forKey: UserDefaultsKeys.email.rawValue)}
    }
    
    var postId: Int {
        get { integer(forKey: UserDefaultsKeys.postId.rawValue)}
        set { setValue(newValue, forKey: UserDefaultsKeys.postId.rawValue)}
    }

}
