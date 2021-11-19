//
//  UILabelExtensionTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 18/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class UILabelExtensionTests: XCTestCase {

    func testHtmlAttributed() {
        let label = UILabel()
        label.setHTMLFromString(htmlText: "TEST")
        expect(label).notTo(beNil())
    }
}
