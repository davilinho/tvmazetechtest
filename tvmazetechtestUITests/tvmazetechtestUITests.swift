//
//  tvmazetechtestUITests.swift
//  tvmazetechtestUITests
//
//  Created by David Martin on 10/11/21.
//

import XCTest

// swiftlint:disable type_name
class tvmazetechtestUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    func testShowFlow() {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["TV Maze API"].exists)

        let cells = app.tables.firstMatch.cells.firstMatch
        XCTAssertTrue(cells.waitForExistence(timeout: 5))
        cells.tap()
    }
}
