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
    var sortMode = Sort.desc
    
    let mainView = PostView()
    let viewModel = PostViewModel()
   
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        bind()
        refresh()
        
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
        
        // 당겨서 새로고침
        mainView.tableView.refreshControl = UIRefreshControl()
        let refreshControl = mainView.tableView.refreshControl!
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        
        
        addAction()
        

        
    }
    
    override func bind() {
        viewModel.loadedPosts.bind { post in
            self.mainView.tableView.reloadData()
        }
    }
    
    @objc func refresh() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.getPosts(sort: self.sortMode) {
                self.mainView.tableView.refreshControl?.endRefreshing()
                        print("포스트 조회 완료")
                    }
        }
//
        
    }
    
   
    
    
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
        self.mainView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
    }
    
    @objc func profileButtonClicked() {
        // 비밀번호 변경페이지로 이동
        let vc = ChangePWViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sortButtonClicked() {
        
        sortActionSheet()
    }
    
    
    @objc func addPostButtonClicked() {
        let vc = PostEditViewController()
        vc.isNewPost = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sortActionSheet() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: "수정하기", style: .default) { _ in
            let vc = PostEditViewController()
            vc.isNewPost = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let descMode = UIAlertAction(title: "최신 글부터 보기", style: .default) { _ in
            self.sortMode = Sort.desc
            self.refresh()
        }
        
        let ascMode = UIAlertAction(title: "오래된 글부터 보기", style: .default) { _ in
            self.sortMode = Sort.asc
            
            self.refresh()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        [descMode, ascMode, cancel].forEach {
            $0.greenAlertText()
        }
            
        
        alert.addAction(descMode)
        alert.addAction(ascMode)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
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
        
        let dateFormat = row.createdAt.StringToDate()!
        cell.dateLabel.text = DateFormatter().simpleDateString(date: dateFormat)
        
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
    
    //postDetailView로 이동하기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, "select: \(indexPath.row)")
        
        let vc = PostDetailViewController()
        let row = self.viewModel.loadedPosts.value[indexPath.row]
        if userDefaults.id == row.user.id {
            vc.isMyPost = true
        } else {
            vc.isMyPost = false
        }
        vc.viewModel.selectedPost.value = row
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
