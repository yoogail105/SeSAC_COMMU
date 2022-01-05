//
//  PostViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import Foundation

class PostViewModel {
    
//    var posts: Observable<Post> = Observable(Post)
    
    func getPosts(completion: @escaping () -> Void) {
        print(#function)
        
        APIService.loadPosts { post, error in
            if error == APIError.unAuthorized {
                UserDefaults.standard.validToken = false
                
            }
            
            guard let post = post else {
                return
            }

            completion()
        }
    }
}
