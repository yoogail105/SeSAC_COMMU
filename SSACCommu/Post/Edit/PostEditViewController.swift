//
//  PostEditViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//

import UIKit
import Toast


class PostEditViewController: BaseViewController {
    let mainView = PostEditView()
    let viewModel = PostEditViewModel()
    
    var editPostId = PostEditViewModel().savePost.value.id
    
    
    var editMode = "새싹농장 글쓰기"
    var isNewPost = true {
        didSet {
            if isNewPost {
                editMode = "새싹농장 글쓰기"
            } else {
                editMode = "새싹농장 글 수정하기"
            }
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.hideKeyboardWhenTapped()
        mainView.textField.autocorrectionType = .no
        mainView.textField.becomeFirstResponder()
        
    }
    
    
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        self.navigationItem.title = editMode
        
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"), style: .done, target: self, action: #selector(saveButtonClicked))
        saveButton.tintColor = UIColor(named: "SSACGreen")
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc override func back() {
        self.makeAlert(message: "글이 저장되지 않았습니다. 목록으로 이동하시겠습니까?", okTitle: "확인") {_ in
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    @objc func saveButtonClicked() {
        print(#function)
        
        if isNewPost {
            if mainView.textField.text != "" {
                viewModel.postAddPosts(text: mainView.textField.text!) {
                    self.mainView.makeToast("저장 되었습니다🌱")
                    self.navigationController?.popViewController(animated: true)
                    print("alert: 작성완료")
                }
            } else {
                print("alert: 내용을 입력해주세요: alert")
            }
        }else {
            print("수정하기", editPostId)
            viewModel.putEditPost(text: mainView.textField.text!, postId: viewModel.savePost.value.id) {
                self.navigationController?.popViewController(animated: true)
                print("alert: 수정완료")
                }
                
            }
        }
      
        
    
    
    override func bind() {
//        viewModel.savePost.bind { post in
//            self.mainView.textField.text = post.text
//
//        }
    }
    
    override func addAction() {
        
    }
    
    
}
