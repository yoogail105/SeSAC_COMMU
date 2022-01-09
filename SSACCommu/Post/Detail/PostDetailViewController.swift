//
//  PostDetailViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//

import Foundation
import UIKit
import Toast

class PostDetailViewController: BaseViewController {
    
    let mainView = PostDetailView()
    let viewModel = PostDetailViewModel()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        mainView.tableView.rowHeight = UITableView.automaticDimension
        viewModel.getComments(postId: viewModel.selectedPost.value.id) {
            print("코멘트불러옴")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setDetailPost()
    }
    
    func setDetailPost() {
        print(viewModel.selectedPost.value)
        let postData = viewModel.selectedPost.value
        mainView.nicknameLabel.text = postData.user.username
        mainView.dateLabel.text = postData.createdAt
        mainView.contentLabel.text = postData.text
        mainView.commentLabel.text = "댓글 \(postData.comments.count)"
    }
    
    override func bind() {
        viewModel.loadedComments.bind { comments in
            self.mainView.tableView.reloadData()
        }
        
//        viewModel.selectedComment.bind { comment in
//            self.mainView.tableView.reloadData()
//        }
    }
    
    override func addAction() {
        self.mainView.addCommentButton.addTarget(self, action: #selector(addCommentButtonClicked), for: .touchUpInside)
    }
    
    @objc func addCommentButtonClicked() {
        if mainView.commentLabel.text != "" {
            viewModel.postAddComment(postId: viewModel.selectedPost.value.id, text: mainView.commentLabel.text!) {
                print("등록 완료")
            }
        } else {
            print("얼럿: 내용을 입력하세요")
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let controlButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.and.pencil.and.ellipsis"), style: .done, target: self, action: #selector(controlButtonClicked))
        controlButton.tintColor = UIColor(named: "SSACGreen")
        self.navigationItem.rightBarButtonItem = controlButton
    }
    
    @objc func controlButtonClicked() {
        setupActionSheet()
    }
    
    func setupActionSheet() {
        // 현재 포스트 정보
        let postData = viewModel.selectedPost
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: "수정하기", style: .default) { _ in
            let vc = PostEditViewController()
            vc.isNewPost = false
            vc.viewModel.savePost = postData
            vc.viewModel.savePost.value.id = postData.value.id
            vc.mainView.textField.text = postData.value.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let delete = UIAlertAction(title: "삭제하기", style: .default) { _ in
            print("삭제: ",postData.value.id)
            self.makeAlert(message: "정말 삭제 하시겠습니까?", okTitle: "확인") { _ in 
                self.viewModel.deleteDeletePost(postId: self.viewModel.selectedPost.value.id) {
                    print("삭제 완료")
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
}


extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count:", self.viewModel.loadedComments.value.count)
            return self.viewModel.loadedComments.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        let row = viewModel.loadedComments.value[indexPath.row]
        
        cell.nicknameLabel.text = row.user.username
        
        cell.commentLabel.text = row.comment
        cell.selectionStyle = .none
        print("nickname: \(row.user.username), comment: \(row.comment)")
        return cell
        
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}
