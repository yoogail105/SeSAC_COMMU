//
//  PostViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import Foundation

class PostViewModel {
    var loadedPosts: Observable<Posts> = Observable(Posts())
    
    func getPosts(sort: Sort, completion: @escaping () -> Void) {
        print(#function)
        APIService.loadPosts(sort: sort) { post, error in
            
            if error == APIError.unAuthorized {
                UserDefaults.standard.reset()
                
                
            }
            
            guard let post = post else {
                return
            }
            
            self.loadedPosts.value = post
            
            completion()
        }
    }
}
