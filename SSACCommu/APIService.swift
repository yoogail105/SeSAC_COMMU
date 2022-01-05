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
    
    // MARK: Change Password
    static func changePW(email: String, currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.changePW.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "currentPassword=\(currentPassword)&newPassword=\(newPassword)&confirmNewPassword=\(confirmNewPassword)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: 포스트 조회(전체 포스트 조회)
    static func checkPosts(confirmNewPassword: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.posts.url)
        request.httpMethod = Method.GET.rawValue
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: 포스트 작성
    // 토큰 유효성 검증: https://stackoverflow.com/questions/46031146/swift-3-0-token-expire-how-will-be-call-the-token-automatically
    
//    if let authorization = response.response?.allHeaderFields["Authorization"] as? String {
//
//                    var newToken : String = authorization
//                    UserDefaults.standard.set(newToken, forKey: "token")
//                    UserDefaults.standard.synchronize()
//                }
//
//
    
    static func loadPost(text: String, completion: @escaping (User?, APIError?) -> Void) {
        
        
        var request = URLRequest(url: Endpoint.posts.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: 포스트 수정
    static func editPost(text: String, completion: @escaping (User?, APIError?) -> Void) {
        let id = UserDefaults.standard.id
        
        var request = URLRequest(url: Endpoint.postDetail(id: id).url)
        request.httpMethod = Method.PUT.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // MARK: 포스트 삭제
    static func deletePost(text: String, completion: @escaping (User?, APIError?) -> Void) {
        let id = UserDefaults.standard.id
        
        var request = URLRequest(url: Endpoint.postDetail(id: id).url)
        request.httpMethod = Method.DELETE.rawValue
            
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
