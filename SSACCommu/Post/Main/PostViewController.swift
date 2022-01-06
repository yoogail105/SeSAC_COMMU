//
//  PostViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/04.
//

import Foundation
import UIKit

class PostViewController: BaseViewController {
    
    let userDefaults = UserDefaults.standard
    
    let mainView = PostView()
    let viewModel = PostViewModel()
    var validToken = UserDefaults.standard.validToken {
        didSet {
            print("토큰 설정 바뀜")
            if validToken == false {
                invalidToken()
                print("validToken:", validToken)
            }
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        bind()
        viewModel.getPosts {
            print("postViewmModel:",#function)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        mainView.tableView.backgroundColor = .white
        
       
        addAction()
        printUserData()
        
        
        
    }
    
    override func bind() {
        viewModel.loadedPosts.bind { post in
            self.mainView.tableView.reloadData()
        }
    }
    
    func invalidToken() {
        print("토큰만료:", #function)
        
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //self.mainView.emailTextField.addTarget(self, action: #selector(
    //emailTextFieldDidChange(_:)), for: .editingChanged)
    
    func printUserData() {
        print(#function)
        print("validToken:",self.userDefaults.validToken)
        print("token:",self.userDefaults.token)
        print("id:", self.userDefaults.id)
        print("nickname:", self.userDefaults.nickname)
        print("email:", self.userDefaults.email)

    }
    
    override func addAction() {
        self.mainView.profileButton.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
        self.mainView.addPostButton.addTarget(self, action: #selector(addPostButtonClicked), for: .touchUpInside)
    }
    @objc func profileButtonClicked() {
        // 비밀번호 변경페이지로 이동
        let vc = ChangePWViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addPostButtonClicked() {
        let vc = PostEditViewController()
        vc.isNewPost = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.loadedPosts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let row = viewModel.loadedPosts.value[indexPath.row]
        
        cell.backgroundColor = .white
        cell.nicknameLabel.text = row.user.username
        cell.contentLabel.text = row.text
        cell.dateLabel.text = row.createdAt
        
        var commentLabelText = ""
        if row.comments.count == 0 {
            commentLabelText = "댓글쓰기"
        } else {
            commentLabelText = "댓글 \(row.comments.count)"
        }
        cell.commentLabel.text = commentLabelText
        cell.selectionStyle = .none
        return cell
    }
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //postDetailView로 이동하기
        print(#function, "select: \(indexPath.row)")
        let row = self.viewModel.loadedPosts.value[indexPath.row]
        UserDefaults.standard.postId = row.id
        
        print("포스트 아이디: ", row.id)
        let vc = PostDetailViewController()
        print("selectedData - index: \(indexPath.row), row: ", row)
        vc.viewModel.selectedPost.value = row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
