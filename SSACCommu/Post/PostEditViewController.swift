//
//  PostEditViewController.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/06.
//

import Foundation
import UIKit

class PostEditViewController: BaseViewController {
    let mainView = PostEditView()
    let viewModel = PostEditViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
