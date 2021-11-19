//
//  UILabel+Extension.swift
//  tvmazetechtest
//
//  Created by David Martin on 18/11/21.
//

import UIKit

extension UILabel {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = String(format: "<div style=\"text-align: center;\"><span style=\"font-family: '-apple-system', 'Verdana'; color: '#E0E0E0'; font-size: 16;\">%@</span></div>", htmlText)
        if let attrStr = try? NSAttributedString(data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
                                                 options: [.documentType: NSAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil) {
            self.attributedText = attrStr
        }
    }
}
