//
//  UILabel+Extension.swift
//  SSACCommu
//
//  Created by 성민주민주 on 2022/01/05.
//

import Foundation
import UIKit

extension UILabel {
    
}

class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
