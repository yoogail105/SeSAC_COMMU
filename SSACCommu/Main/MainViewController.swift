//
//  MainViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import Foundation
import UIKit

class MainViewController: BaseViewController {
    
    let userDefaults = UserDefaults.standard
    var mainView = MainView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if userDefaults.isTokenExpired == true {
            self.makeAlertWithoutCancel(message: "로그인 정보가 만료되었습니다.\n다시 로그인 해주세요😇",
                                        okTitle: "확인") { _ in
                self.userDefaults.isTokenExpired.toggle()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("메인화면왔음")
        printUserData()
        mainView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func signUpButtonClicked() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signInButtonClicked() {
        let vc = SignInViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func printUserData() {
        print(#function)
        print("validToken:",self.userDefaults.validToken)
        print("token:",self.userDefaults.token)
        print("id:", self.userDefaults.id)
        print("nickname:", self.userDefaults.nickname)
        print("email:", self.userDefaults.email)
        
    }
}
