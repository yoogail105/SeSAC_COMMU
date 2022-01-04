//
//  APIService.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/04.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}


class APIService {
    
    // MARK: SignUp
    static func signUp(userName: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void ) {
        var request = URLRequest(url: Endpoint.signUp.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(userName)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
//        request.httpBody = "username=hoi&email=ss@ss.com&password=1234".data(using: .utf8, allowLossyConversion: false)

        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: SignIn
    static func signIn(email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.signIn.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        //request.httpBody = "identifier=lala@sessac.com&password=1234".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    
    
    
    
}
