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
    case unAuthorized
    
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
    
    // MARK: Change Password [ ]
    static func changePW(email: String, currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.changePW.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "currentPassword=\(currentPassword)&newPassword=\(newPassword)&confirmNewPassword=\(confirmNewPassword)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: 포스트 조회(전체 포스트 조회)
    static func loadPosts(completion: @escaping (Posts?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.posts.url)
        let token = UserDefaults.standard.token!
        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }

    // MARK: 포스트 작성
    static func addPosts(text: String, completion: @escaping (Post?, APIError?) -> Void) {
        let token = UserDefaults.standard.token!
        var request = URLRequest(url: Endpoint.addPost.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.request(endpoint: request, completion: completion)
    }

    // MARK: 포스트 수정
    static func editPost(text: String, postId: Int, completion: @escaping (Posts?, APIError?) -> Void) {
        let token = UserDefaults.standard.token!
        var request = URLRequest(url: Endpoint.postDetail(id: postId).url)
        request.httpMethod = Method.PUT.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.request(endpoint: request, completion: completion)
    }

    // MARK: 포스트 삭제
    static func deletePost(postId: Int, completion: @escaping (Post?, APIError?) -> Void) {
        let id = UserDefaults.standard.id
        let token = UserDefaults.standard.token!
        var request = URLRequest(url: Endpoint.postDetail(id: id).url)
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: 코멘트 조회
    // http://base-URL/comments?post=1
    static func laodComments(postId: String, completion: @escaping (User?, APIError?) -> Void) {
        let postId = 1
        
        var request = URLRequest(url: Endpoint.comments.url)
        request.httpMethod = Method.GET.rawValue
        request.httpBody = "?post=\(postId)".data(using: .utf8, allowLossyConversion: false)
            
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: 코멘트 작성
    static func addComment(postId: Int, comment: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.commentDetail(id: postId).url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "comment=\(comment)&post=\(postId)".data(using: .utf8, allowLossyConversion: false)
            
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: 코멘트 수정
    static func editComment(postId: Int, comment: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.commentDetail(id: postId).url)
        request.httpMethod = Method.PUT.rawValue
        request.httpBody = "comment=\(comment)&post=\(postId)".data(using: .utf8, allowLossyConversion: false)
            
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: 코멘트 삭제
    static func deleteComment(postId: Int, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.commentDetail(id: postId).url)
        request.httpMethod = Method.DELETE.rawValue
            
        URLSession.request(endpoint: request, completion: completion)
    }
}
