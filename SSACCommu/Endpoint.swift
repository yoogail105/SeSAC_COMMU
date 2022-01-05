//
//  Endpoint.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/04.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum Endpoint {
    case signUp
    case signIn
    case changePW
    case posts
    case postDetail(id: Int)
    case comments
    case commentDetail(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signUp:
            return .makeEndPoint("auth/local/register")
        case .signIn:
            return .makeEndPoint("auth/local")
        case .changePW:
            return .makeEndPoint("custom/change-password")
        case .posts:
            return .makeEndPoint("posts")
       case .postDetail(id: let id):
            return .makeEndPoint("posts/\(id)")
        case .comments:
            return .makeEndPoint("comments")
        case .commentDetail(id: let id):
            return .makeEndPoint("comments/\(id)")
        }
    }
}
// http://test.monocoding.com/auth/local
// http://test.monocoding.com:1231/auth/local

extension URL {
    static let baseURL = "http://test.monocoding.com:1231/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
        
    }

}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
            session.dataTask(endpoint) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                    
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                    
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("error3: 여기오류")
                    completion(nil, .invalidData)
                    return
                }
                
                guard response.statusCode == 200 else {
                    if response.statusCode == 401 {
                        print("토큰만료: 로그아웃합니다.")
                        UserDefaults.standard.validToken = false
                        UserDefaults.standard.token = ""
                        return
                    }
                    // 오류 확인
                    do {
                        print("statusCode: ", response.statusCode)
                        
                        let decoder = JSONDecoder()
                        let errorDetail = try decoder.decode(ErrorDetail.self, from: data)
                        completion(nil, .failed)
                        print(errorDetail.message)
                        return
                    } catch {
                        print("200아닐떄: do-catch: 여기오류")
                        completion(nil, .invalidData)
                        return
                    }
                }
                
                
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil)
                } catch {
                    print("do-catch: 여기오류")
                    completion(nil, .invalidData)
                }
            }
        }
    }
}
