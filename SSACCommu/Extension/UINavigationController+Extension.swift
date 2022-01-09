//
//  UINavigationController+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/10.
//

import UIKit

extension UINavigationController {
    
    func popViewControllerWithHandler(animated: Bool = true, completion: @escaping () ->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func pushViewController(viewController: UIViewController, animated: Bool = true, completion: @escaping () -> ()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}

