//
//  ChangePWViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import Foundation
import UIKit

class ChangePWViewController: BaseViewController {
    
    var mainView = ChangePWView()
    var viewModel = ChangePWViewModel()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
     

    }
    
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        self.navigationItem.title = "비밀번호 변경하기"
    }
    
    override func bind() {
        viewModel.currentPassword.bind { text in
            self.mainView.currentPasswordTextField.text = text
        }

        viewModel.newPassword.bind { text in
            self.mainView.newPasswordTextField.text = text
        }
        
        viewModel.confirmNewPassword.bind { text in
            self.mainView.confirmNewPasswordTextField.text = text
        }
    }
    
    override func addAction() {
        
        self.mainView.changeButton.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
        self.mainView.logoutButton.addTarget(self, action: #selector(logoutButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func changeButtonClicked() {
        print("비밀번호 변경하기 버튼 클릭")

        viewModel.postChangePassword(currentPassword: mainView.currentPasswordTextField.text!, newPassword: mainView.newPasswordTextField.text!, confirmNewPassword: mainView.confirmNewPasswordTextField.text!) {
            print("성공했다.")
        }
        
    }
    @objc func logoutButtonClicked() {
        
        self.makeAlert(message: "로그아웃 하시겠습니까?", okTitle: "로그아웃") { _ in
            // userDefaults 정보 지우기
            UserDefaults.standard.reset()
            print("지웠다:",UserDefaults.standard.validToken, UserDefaults.standard.id)
            
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
     
    }
}
