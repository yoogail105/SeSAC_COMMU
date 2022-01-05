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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        print("confirmed:", self.userDefaults.confirmed)
    }
}
