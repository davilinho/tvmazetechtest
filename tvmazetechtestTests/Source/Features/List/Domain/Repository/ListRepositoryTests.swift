//
//  ListRepositoryTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class ListRepositoryTests: XCTestCase {

    @Inject
    private var repository: ListRepository

    func testGetFirstPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.fetch { (models: [Show]) in
                expect(models).toNot(beNil())
                done()
            }
        }
    }

    func testGetSecondPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.fetch(by: 1) { (models: [Show]) in
                expect(models).toNot(beNil())
                done()
            }
        }
    }

    func testGetPageOutOfRangeFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.fetch(by: 100000000) { (models: [Show]) in
                expect(models).to(beEmpty())
                done()
            }
        }
    }

    func testGetSearchSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.search(by: "Cars") { (models: [SearchResponse]) in
                expect(models).toNot(beNil())
                done()
            }
        }
    }

    func testGetSearchFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.search(by: "SHOW NOT FOUND") { (models: [SearchResponse]) in
                expect(models).to(beEmpty())
                done()
            }
        }
    }
}
