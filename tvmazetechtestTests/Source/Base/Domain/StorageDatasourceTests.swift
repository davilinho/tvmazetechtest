//
//  StorageDatasourceTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class StorageDatasourceTests: XCTestCase {
    @StorageDatasource
    private var value: String?

    override func setUp() {
        super.setUp()
        self.value = "TEST"
    }

    func testSaveSuccessful() {
        expect(self.value).toNot(beNil())
        expect(self.value).to(equal("TEST"))
    }

    func testClearSuccessful() {
        self.value = nil
        expect(self.value).to(beNil())
    }
}
