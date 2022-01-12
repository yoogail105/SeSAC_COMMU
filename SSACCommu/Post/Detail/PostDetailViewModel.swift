//
//  PostDetailViewModel.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//

import Foundation


class PostDetailViewModel {
    
    var selectedPost: myObservable<Post> = myObservable(Post(id: 0, text: "",
                                                         user: UserData(id: 0, username: "", email: "", createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "",
                                                         comments: [PostComment]()))
    
    let loadedComments: myObservable<Comments> = myObservable(Comments())
    
    let selectedComment: myObservable<Comment> = myObservable(Comment(id: 0, comment: "", user: UserData(id: 0, username: "", email: "", createdAt: "", updatedAt: ""), createdAt: "", updatedAt: ""))
    
    func getSelectedPost(postId: Int, completion: @escaping () -> Void) {
        APIService.selectedPost(postId: postId) { post, error in
            guard let post = post else {
                return
            }
            
            self.selectedPost.value = post
            completion()
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
    
    func getComments(postId: Int, completion: @escaping () -> Void) {
        print(#function)
        
        APIService.loadComments(postId: postId) { comments, error in
            
            
            guard let comments = comments else {
                return
            }
            
            self.loadedComments.value = comments
            // print("Comments:", self.loadedComments.value.count)
            completion()
            
        }
    }
    
    func postAddComment(postId: Int, text: String, completion: @escaping () -> Void) {
        print(#function)
        APIService.addComment(postId: postId, comment: text) { comment, error in
            guard let comment = comment else {
                return
            }
            
            self.selectedComment.value = comment
            
            completion()
            
        }
    }
    
    func putEditComment(postId: Int, commentId: Int, comment: String, completion: @escaping () -> Void) {
        print(#function)
        APIService.editComment(postId: postId, commentId: commentId, comment: comment) { comment, error in
            guard let comment = comment else {
                return
            }
            
            self.selectedComment.value = comment
            
            completion()
        }
    }
    
    func deleteComment(commentId: Int, completion: @escaping () -> Void) {
        print(#function)
        APIService.deleteComment(commentId: commentId) { comment, error in
            guard let comment = comment else {
                return
            }
            self.selectedComment.value = comment
            
            completion()
        }
    }
    
}
