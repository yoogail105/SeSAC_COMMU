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
        view.backgroundColor = .green
        return view
    }()

    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cyan
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(fatalError())
    }
    
    func configure() {
        
    }
    
    func constraints() {
        [headerView, tableView].forEach {
            addSubview($0)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(44)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
    }
}
