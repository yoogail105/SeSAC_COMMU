//
//  UIViewController+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/10.
//

import UIKit

extension UIViewController {
    
    
    
    func makeAlert(message: String, okTitle: String, okAction: @escaping ((UIAlertAction) -> Void)) {
        
            //UIColor(named: "SSACGreen")
   
        self.view.tintColor = UIColor(named: "SSACGreen")
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        
//        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: okAction))
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okAction)
        okAction.redAlertText()
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        cancelAction.greenAlertText()
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    func makeAlertWithoutCancel(message: String, okTitle: String, okAction: ((UIAlertAction) -> Void)?) {
        
            //UIColor(named: "SSACGreen")
   
        self.view.tintColor = UIColor(named: "SSACGreen")
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        
//        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: okAction))
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okAction)
        okAction.redAlertText()
        alert.addAction(okAction)

        
        self.present(alert, animated: true)
    }
    
 
    func makeActionSheet(editAction: @escaping ((UIAlertAction) -> Void), deleteAction:@escaping ((UIAlertAction) -> Void) ) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: "수정하기", style: .default, handler: editAction)
        edit.greenAlertText()
        
        let delete = UIAlertAction(title: "삭제하기", style: .default, handler: deleteAction)
        delete.redAlertText()
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        cancel.greenAlertText()
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
