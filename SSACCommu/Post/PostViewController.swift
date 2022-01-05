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
    
    let postView = PostView()
    let viewModel = PostViewModel()
    
    
    override func loadView() {
        self.view = postView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postView.tableView.delegate = self
        postView.tableView.dataSource = self
        
        postView.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        postView.tableView.rowHeight = UITableView.automaticDimension
        
        postView.tableView.backgroundColor = UIColor(named: "SSACGray")
        
        printUserData()
        
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
        print("confirmed:", self.userDefaults.confirmed)
    }
    
    
    
    @objc func profileButtonClicked() {
        
    }
}

extension PostViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .white
       // cell.selectionStyle = .none
        return cell
    }
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("select: \(indexPath.row)")
    }
    
}
