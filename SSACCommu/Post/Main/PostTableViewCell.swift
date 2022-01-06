//
//  File.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {
    static let identifier = "PostTableViewCell"
    
    var nicknameLabel: BasePaddingLabel = {
        let label = BasePaddingLabel(padding: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        label.backgroundColor = UIColor(named: "SSACGray")
        label.text = "미묘한 도사"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        return label
    }()
    
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "드라이브가실 분ㅣ 심ㅅ미해요\n드라이브가실 분ㅣ심ㅅ미해요\n드라이브가실 분ㅣ 심ㅅ미해요\n거래완료되었으면................"
        label.textColor = .black
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)

        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.text = "12/08"
        return label
    }()
    
    var lineView: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
        label.text = "댓글쓰기"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    var footerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "SSACGray")
        return view
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
        
        
        [commentImage, commentLabel].forEach {
            commentStackView.addArrangedSubview($0)
        }
        
        [nicknameLabel, contentLabel, dateLabel, lineView, commentStackView, footerView].forEach {
            contentView.addSubview($0)
        }
        
        
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(14)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-14)
            
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(lineView.snp.top).offset(-20)
            $0.leading.equalTo(nicknameLabel.snp.leading)
        }
//
        lineView.snp.makeConstraints {
            $0.bottom.equalTo(commentStackView.snp.top).offset(-5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
//
        commentStackView.snp.makeConstraints {
            $0.bottom.equalTo(footerView.snp.top).offset(-5)
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.height.equalTo(20)
        }

        footerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(5)
        }
    }
    
}
