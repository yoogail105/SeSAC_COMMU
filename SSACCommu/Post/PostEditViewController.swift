//
//  PostEditViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//

import Foundation
import UIKit
import RxSwift
import RxKeyboard


class PostEditViewController: BaseViewController {
    let mainView = PostEditView()
    let viewModel = PostEditViewModel()
    
    let disposeBag = DisposeBag()
    
    var editMode = "작성"
    var isNewPost = true {
        didSet {
            if !isNewPost {
                editMode = "수정"
            }
        }
    }
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()

        self.navigationItem.title = editMode

        let saveButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(saveButtonClicked))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    
}
