//
//  BaseViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import UIKit
import SnapKit

/*
 BaseViewController
 뷰 객체에 대한 UI, 레이아웃, 토스트 메세지, 얼럿, 임포트 등
 VC에서 공통적으로 작성 되는 코드를 구조화
 -> 가독성을 높이고 코드 중복을 줄인다.
 */


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        
    }
}
