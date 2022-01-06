//
//  PostDetailViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//

import Foundation

class PostDetailViewModel {
    
    let selectedPost: Observable<Post> = Observable(Post(id: 0, text: "",
                                                         user: UserData(id: 0, username: "", email: "", createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "",
                                                         comments: [PostComment]()))
    
    let loadedComments: Observable<Comments> = Observable(Comments())
    
    func getComments(postId: Int, completion: @escaping () -> Void) {
        print(#function)
        
        APIService.loadComments(postId: postId) { comments, error in
            
            
            guard let comments = comments else {
                return
            }

            self.loadedComments.value = comments
            print("Comments:", self.loadedComments.value.count)
            
        }
    }
    
    
    func deleteDeletePost(postId: Int, completion: @escaping () -> Void) {
        APIService.deletePost(postId: postId) { post, error in
            guard let post = post else {
                return
            }
            print(post)
            self.selectedPost.value = post
            completion()
        }
    }
    
    
}
