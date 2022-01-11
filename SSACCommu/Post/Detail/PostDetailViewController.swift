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
    var isEditComment = false
    var isMyPost = false
    var isMyComment = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        mainView.tableView.rowHeight = UITableView.automaticDimension
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setDetailPost()
        getComments()
    }
    
    func setDetailPost() {
        print(viewModel.selectedPost.value)
        let postData = viewModel.selectedPost.value
        mainView.nicknameLabel.text = postData.user.username
        

        let CreateDateString = postData.createdAt.StringToDate()!
        let dateStr = DateFormatter().fullDateString(date: CreateDateString)
    
        print(Date())
        
        // let resultDate = dateFormatter.date(from: dateStr)
        mainView.dateLabel.text = dateStr
        mainView.contentLabel.text = postData.text
        mainView.commentLabel.text = "댓글 \(postData.comments.count)"
    }
    
    func getComments() {
        viewModel.getComments(postId: viewModel.selectedPost.value.id) {
            print("코멘트불러옴")
            self.mainView.tableView.reloadData()
        }
    }
    
    override func bind() {
        //        viewModel.loadedComments.bind { comments in
        //            self.mainView.tableView.reloadData()
        //        }
        //
        //        viewModel.selectedComment.bind { comment in
        //            self.mainView.tableView.reloadData()
        //        }
    }
    
    override func addAction() {
        self.mainView.addCommentButton.addTarget(self, action: #selector(addCommentButtonClicked), for: .touchUpInside)
    }
    
    @objc func addCommentButtonClicked() {
        let comment = mainView.addCommentTextField.text!
        
        if comment != "" {
            if !isEditComment {
                print("작성한 코멘트: \(comment), post id: \(viewModel.selectedPost.value.id)")
                viewModel.postAddComment(postId: viewModel.selectedPost.value.id, text: comment) {
                    self.getComments()
                    print("코멘트 등록 완료")
                    self.mainView.addCommentTextField.text = ""
                }
            } else { // 코멘트 수정하고 등록 누름
                print("postID: \(self.viewModel.selectedPost.value.id), commentID: \(self.viewModel.selectedComment.value.id), comment: \(comment)")
                self.viewModel.putEditComment(postId: self.viewModel.selectedPost.value.id, commentId: self.viewModel.selectedComment.value.id, comment: comment) {
                    self.isEditComment = false
                    self.getComments()
                    print("수정완료")
                    self.mainView.addCommentTextField.text = ""
                    
                }
            }
            
        }
        else {
            print("얼럿: 내용을 입력하세요")
        }
    }
    
    
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        if isMyPost {
            let controlButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.and.pencil.and.ellipsis"), style: .done, target: self, action: #selector(controlButtonClicked))
            controlButton.tintColor = UIColor(named: "SSACGreen")
            self.navigationItem.rightBarButtonItem = controlButton
        }
    }
    
    @objc func controlButtonClicked() {
        let postData = viewModel.selectedPost
        
        self.makeActionSheet { _ in
            let vc = PostEditViewController()
            vc.isNewPost = false
            vc.viewModel.savePost = postData
            vc.viewModel.savePost.value.id = postData.value.id
            vc.mainView.textField.text = postData.value.text
            self.navigationController?.pushViewController(vc, animated: true)
        } deleteAction: { _ in
            print("삭제: ",postData.value.id)
            self.makeAlert(message: "삭제하시겠습니까?", okTitle: "확인") { _ in
                self.viewModel.deleteDeletePost(postId: self.viewModel.selectedPost.value.id) {
                    print("삭제 완료")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func controlCommentButtonClicked(comment: Comment) {
        print("버튼 클릭됨")
        self.makeActionSheet { _ in
            // 수정하기
            print("코멘트 수정 모드")
            self.mainView.addCommentTextField.text = comment.comment
            self.isEditComment = true
            
        } deleteAction: { _ in
            //삭제하기 -> alert
            self.makeAlert(message: "댓글을 삭제 하시겠습니까?", okTitle: "확인") { _ in
                self.viewModel.deleteComment(commentId: comment.id) {
                    print("삭제완료")
                    self.getComments()
                }
                
            }
        }
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
        cell.dateLabel.text = self.setDateLabel(dateString: row.createdAt)
        
        cell.selectionStyle = .none
        print("nickname: \(row.user.username), comment: \(row.comment)")
        
        if UserDefaults.standard.id == row.user.id {
            cell.controlButton.isHidden = false
        } else {
            cell.controlButton.isHidden = true
            cell
        }
        
        //cell.controlButton.addTarget(self, action: #selector(controlCommentButtonClicked(sender:)), for: .touchUpInside)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.viewModel.loadedComments.value[indexPath.row]
        self.viewModel.selectedComment.value = row
        controlCommentButtonClicked(comment: viewModel.selectedComment.value)
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 100
    //    }
}
