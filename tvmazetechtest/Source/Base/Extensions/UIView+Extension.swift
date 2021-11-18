//
//  UIView+Extension.swift
//  tvmazetechtest
//
//  Created by David Martin on 18/11/21.
//

import UIKit

extension UIView {
    func rounded() {
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
