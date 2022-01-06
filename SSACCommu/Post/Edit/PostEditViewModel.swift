//
//  PostEditViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//

import Foundation

class PostEditViewModel {
    
    let savePost: Observable<Post> = Observable(Post(id: 0, text: "",
                                                         user: UserData(id: 0, username: "", email: "", createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "",
                                                         comments: [Comment]()))
    func postAddPosts(text: String, completion: @escaping () -> Void) {
        print(#function)
        
        APIService.addPosts(text: text) { post, error in
            if error == APIError.unAuthorized {
                UserDefaults.standard.validToken = false
               
            }
            
            guard let post = post else {
                return
            }
            print(post)
            self.savePost.value = post

            completion()
        }
    }
    
    
    
}
