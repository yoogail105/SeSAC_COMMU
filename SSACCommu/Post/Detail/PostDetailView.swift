//
//  PostDetailView.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import UIKit
import SnapKit

class PostDetailView: UIView {
    
    let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 50
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        //stackView.backgroundColor = .brown
        return stackView
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = UIColor(named: "SSACGray")
        return imageView
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = "당근"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "2222"
        return label
    }()
    
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "드라이브가실 분ㅣ 심ㅅ미해요\n드라이브가실 분ㅣ심ㅅ미해요\n드라이브가실 분ㅣ 심ㅅ미해요\n거래완료되었으면................"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    
    var commentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    var commentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "message")
        imageView.tintColor = .gray
        return imageView
    }()
    
    var commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "댓글 0"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let addCommentTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "SSACGray")
        textField.placeholder = "댓글을 입력해 주세요."
        textField.layer.cornerRadius = 12
        return textField
    }()
    
    let addCommentButton: UIButton = {
        let button = UIButton()
        button.greenButtonImageSize(imageName: "checkmark.rectangle.fill", size: 40)
        return button
    }()
    
//    let headerLineView = UIView()
//    let contentLineView = UIView()
//    let commentStackViewLineView = UIView()
//    let commentTableViewLineView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
//        [headerLineView, contentLineView, commentStackViewLineView, commentTableViewLineView].forEach {
//            $0.backgroundColor = UIColor(named: "SSACGray")
//        }
    }
    
    func constraints() {
        [profileImageView, nicknameLabel, dateLabel].forEach {
            headerView.addSubview($0)
        }
        
        [contentLabel].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        [commentImage, commentLabel].forEach {
            commentStackView.addArrangedSubview($0)
        }
        
        [headerView, contentStackView, commentStackView, tableView, addCommentTextField, addCommentButton].forEach {
            addSubview($0)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(60)
        }
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalTo(headerView.snp.leading)
            $0.centerY.equalTo(headerView.snp.centerY)
            $0.height.width.equalTo(40)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(5)
            $0.bottom.equalTo(profileImageView.snp.centerY).offset(-1)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.top.equalTo(profileImageView.snp.centerY).offset(3)
        }
        
        
//        headerLineView.snp.makeConstraints {
//            $0.bottom.equalTo(headerView.snp.bottom)
//            $0.leading.equalTo(headerView.snp.leading)
//            $0.trailing.equalTo(headerView.snp.trailing)
//            $0.height.equalTo(1)
//        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            $0.leading.equalTo(headerView.snp.leading)
            $0.trailing.equalTo(headerView.snp.trailing)
        }
        
//        contentLineView.snp.makeConstraints {
////            $0.top.equalTo(contentLabel.snp.bottom).offset(30)
//            $0.height.equalTo(1)
//        }
        
        commentStackView.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.bottom).offset(20)
            $0.leading.equalTo(headerView.snp.leading)
        }
        
//        commentStackViewLineView.snp.makeConstraints {
//            $0.height.equalTo(1)
//            $0.top.equalTo(contentStackView.snp.bottom).offset(-1)
//        }
//
        tableView.snp.makeConstraints {
            $0.top.equalTo(commentStackView.snp.bottom).offset(10)
            $0.leading.equalTo(headerView.snp.leading)
            $0.trailing.equalTo(headerView.snp.trailing)
            $0.bottom.equalTo(addCommentTextField.snp.top).offset(-10)
        }

//        commentTableViewLineView.snp.makeConstraints {
//            $0.height.equalTo(1)
//            $0.top.equalTo(addCommentTextField.snp.top).offset(-5)
//        }
//
        addCommentTextField.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            $0.leading.equalTo(headerView.snp.leading)
            $0.trailing.equalTo(headerView.snp.trailing).offset(-50)
            $0.height.equalTo(44)
        }
        
        addCommentButton.snp.makeConstraints {
            $0.top.equalTo(addCommentTextField.snp.top)
            $0.leading.equalTo(addCommentTextField.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
            
        }
    }
