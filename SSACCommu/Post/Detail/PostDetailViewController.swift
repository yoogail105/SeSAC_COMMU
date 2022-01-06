//
//  PostDetailViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//

import Foundation
import UIKit
class PostDetailViewController: BaseViewController {

    let mainView = PostDetailView()
    let viewModel = PostDetailViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bind() {
        print(viewModel.selectedPost.value)
        let postData = viewModel.selectedPost.value
        mainView.nicknameLabel.text = postData.user.username
        mainView.dateLabel.text = postData.createdAt
        mainView.contentLabel.text = postData.text
        //mainView.nicknameLabel.text = postData.user.username
        
    }
    
    override func addAction() {
    
    }
    
}
