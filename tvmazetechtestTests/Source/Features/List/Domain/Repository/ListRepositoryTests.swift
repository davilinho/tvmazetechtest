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
    private var repository: ListRepository?

    @Inject
    private var store: StoreShowsDatasource?

    override func setUp() {
        super.setUp()
        self.store?.clear()
    }

    func testGetFirstPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let models: [Show] = await self.repository?.fetch() {
                    expect(models).toNot(beNil())
                    done()
                }
            }
        }
    }

    func testGetFirstPageStoredSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let _: [Show] = await self.repository?.fetch() {
                    expect(self.store?.retrieve()?.models).toNot(beNil())
                    done()
                }
            }
        }
    }

    func testGetSecondPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let models: [Show] = await self.repository?.fetch(by: 1) {
                    expect(models).toNot(beNil())
                    done()
                }
            }
        }
    }

    func testGetSecondPageStoredSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let _: [Show] = await self.repository?.fetch(by: 1) {
                    expect(self.store?.retrieve()?.models).toNot(beNil())
                    done()
                }
            }
        }
    }

    func testGetPageOutOfRangeFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let models: [Show] = await self.repository?.fetch(by: 100000000) {
                    expect(models).to(beEmpty())
                    done()
                }
            }
        }
    }

    func testGetPageOutOfRangeStoredFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let _: [Show] = await self.repository?.fetch(by: 100000000) {
                    expect(self.store?.retrieve()?.models).to(beNil())
                    done()
                }
            }
        }
    }

    func testGetSearchSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let models: [Show] = await self.repository?.search(by: "Cars") {
                    expect(models).toNot(beNil())
                    done()
                }
            }
        }
    }

    func testGetSearchStoredSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let _: [Show] = await self.repository?.search(by: "Cars") {
                    expect(self.store?.retrieve()?.models).toNot(beNil())
                    done()
                }
            }
        }
    }

    func testGetSearchFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let models: [Show] = await self.repository?.search(by: "SHOW NOT FOUND") {
                    expect(models).to(beEmpty())
                    done()
                }
            }
        }
    }

    func testGetSearchStoredFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let _: [Show] = await self.repository?.search(by: "SHOW NOT FOUND") {
                    expect(self.store?.retrieve()?.models).to(beEmpty())
                    done()
                }
            }
        }
    }
}
