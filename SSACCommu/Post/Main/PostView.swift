//
//  PostView.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/04.
//

import UIKit
import SnapKit

class PostView: UIView {
    
    let headerView: UIView = {
        let view = UIView()
        return view
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹농장🌱"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    
    let profileButton: UIButton = {
       let button = UIButton()
        button.greenButtonImageSize(imageName: "person", size: 25)
        return button
    }()
    
    let sortButton: UIButton = {
       let button = UIButton()
        button.greenButtonImageSize(imageName: "arrow.up.arrow.down", size: 25)
        return button
    }()
    
    let addPostButton: UIButton = {
        let button = UIButton()
        button.greenButtonImageSize(imageName: "plus.circle.fill", size: 55)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize.zero
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
    }
    
    func constraints() {
        addSubview(headerView)
      
        [headerView, tableView, addPostButton].forEach {
            addSubview($0)
        }
        [titleLabel, profileButton, sortButton].forEach {
            headerView.addSubview($0)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(44)
            $0.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        profileButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        sortButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(profileButton.snp.leading).offset(-5)
        }
        
        addPostButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
    }
}
