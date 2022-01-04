//
//  PostViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/04.
//

import Foundation
import UIKit

class PostViewController: BaseViewController {
    
    
    let mainView = PostView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
