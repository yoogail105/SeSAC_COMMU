//
//  CommentTableViewCell.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//


import UIKit
import SnapKit

class CommentTableViewCell: UITableViewCell {
    static let identifier = "CommentTableViewCell"
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "호호호호"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글\n댓글\n댓글\n댓글\n\n\n\n댓글"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    var controlButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        button.tintColor = .black
        return button
    }()
    
    var dateLabel: UILabel = {
       let label = UILabel()
        label.text = "01/11 06:16"
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .darkGray

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func configure() {
        
    }
    
    func constraints() {
        
    
    
        [nicknameLabel, commentLabel, dateLabel, controlButton].forEach {
            addSubview($0)
        }
        
        controlButton.snp.makeConstraints {
            $0.centerY.equalTo(nicknameLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.width.equalTo(20)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalTo(controlButton.snp.leading)
            $0.height.equalTo(20)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom)
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.trailing.equalTo(nicknameLabel.snp.trailing)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom)
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.trailing.equalTo(nicknameLabel.snp.trailing)
            $0.height.equalTo(15)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        
        
    }
    
}

