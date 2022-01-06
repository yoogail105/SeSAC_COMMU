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
                                                         comments: [Comment]()))
    let laodComents: Observable<Comments> = Observable(Comments())
    
    
    
    
}
