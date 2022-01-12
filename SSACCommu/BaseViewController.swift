//
//  BaseViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/03.
//

import UIKit
import SnapKit
import Toast

/*
 BaseViewController
 뷰 객체에 대한 UI, 레이아웃, 토스트 메세지, 얼럿, 임포트 등
 VC에서 공통적으로 작성 되는 코드를 구조화
 -> 가독성을 높이고 코드 중복을 줄인다.
 */


class BaseViewController: UIViewController {
    
    var toast = SimpleToastView()
    
    var validToken = UserDefaults.standard.validToken {
        didSet {
            print("토큰 설정 바뀜")
            if validToken == false {
                invalidToken()
                print("validToken:", validToken)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupNavigationBar()
        configure()
        bind()
        addAction()
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        
    }

    
    func setupNavigationBar() {
        self.navigationItem.title = ""
        self.navigationItem.backButtonTitle = ""
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .done, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "SSACGreen")
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func invalidToken() {
        print("토큰만료:", #function)
        makeAlertWithoutCancel(message: "로그인 정보가 만료되었습니다. 다시 로그인을 해주세요😇", okTitle: "확인") { _ in
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    func showToast(message: String) {
        self.view.addSubview(toast)
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: { self.toast.alpha = 0.0}, completion: {_ in
             self.toast.removeFromSuperview()})
    }
    
    func showToast22(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: { toastLabel.alpha = 0.0 }, completion: {(isCompleted) in toastLabel.removeFromSuperview() })
    }
    
    func bind() {
        
    }
    
    func addAction() {
        
    }
    
    func setDateLabel(dateString: String) -> String{
        let dateFormatter = DateFormatter()
        let changedDateFormat = dateString.StringToDate()!
        
        let result = dateFormatter.fullDateString(date: changedDateFormat)
        
        
        return result
    }

}
