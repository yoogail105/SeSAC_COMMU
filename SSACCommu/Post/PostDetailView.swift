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
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let headerBottomLineView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    let contentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let contentBottomLineView: UIView = {
        let view = UIView()
        return view
    }()
    
    let commentBottomLineView: UIView = {
        let view = UIView()
        return view
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
        [profileImageView, nicknameLabel, dateLabel, headerBottomLineView].forEach {
            headerView.addSubview($0)
        }
        
        [profileImageView, nicknameLabel, dateLabel].forEach {
            contentView.addSubview($0)
        }
        [headerView, contentView].forEach {
            addSubview($0)
        }
        
        
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(60)
        }
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        
        
        
    }
}
