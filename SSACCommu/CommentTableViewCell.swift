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
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글\n댓글\n댓글\n댓글\n\n\n\n댓글"
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
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
        
    
    
        [nicknameLabel, commentLabel, controlButton].forEach {
            addSubview($0)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-44)
        }
        
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-44)
        }
        
        controlButton.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.top)
            $0.trailing.equalToSuperview()
            $0.height.width.equalTo(30)
        }
        
    }
    
}
