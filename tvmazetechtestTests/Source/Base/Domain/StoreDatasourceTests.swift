//
//  StoreDatasourceTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class StoreDatasourceTests: XCTestCase {
    private var store: StoreDatasource<String> = {
        return StoreDatasource<String>()
    }()

    override func setUp() {
        super.setUp()
        self.store.save(value: "TEST")
    }

    func testSaveSuccessful() {
        expect(self.store.retrieve()).toNot(beNil())
        expect(self.store.retrieve()).to(equal("TEST"))
    }

    func testClearSuccessful() {
        self.store.clear()
        expect(self.store.retrieve()).to(beNil())
    }
}
