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

    @Inject
    private var store: StoreShowsDatasource

    override func setUp() {
        super.setUp()
        self.store.clear()
    }

    func testGetFirstPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.fetch { (models: [Show]) in
                expect(models).toNot(beNil())
                done()
            }
        }
    }

    func testGetFirstPageStoredSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.fetch { _ in
                expect(self.store.retrieve()?.models).toNot(beNil())
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

    func testGetSecondPageStoredSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.fetch(by: 1) { _ in
                expect(self.store.retrieve()?.models).toNot(beNil())
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

    func testGetPageOutOfRangeStoredFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.fetch(by: 100000000) { _ in
                expect(self.store.retrieve()?.models).to(beNil())
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

    func testGetSearchStoredSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.search(by: "Cars") { _ in
                expect(self.store.retrieve()?.models).toNot(beNil())
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

    func testGetSearchStoredFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.repository.search(by: "SHOW NOT FOUND") { _ in
                expect(self.store.retrieve()?.models).to(beEmpty())
                done()
            }
        }
    }
}
