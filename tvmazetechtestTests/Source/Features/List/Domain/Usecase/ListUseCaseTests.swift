//
//  ListUseCaseTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class ListUseCaseTests: XCTestCase {

    @Inject
    private var useCase: ListUseCase

    func testGetFirstPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.useCase.fetch { (models: [Show]) in
                expect(models).toNot(beNil())
                done()
            }
        }
    }

    func testGetSecondPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.useCase.fetch(by: 1) { (models: [Show]) in
                expect(models).toNot(beNil())
                done()
            }
        }
    }

    func testGetPageOutOfRangeFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.useCase.fetch(by: 100000000) { (models: [Show]) in
                expect(models).to(beEmpty())
                done()
            }
        }
    }

    func testGetSearchSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.useCase.search(by: "Cars") { (models: [Show]) in
                expect(models).toNot(beNil())
                done()
            }
        }
    }

    func testGetSearchFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.useCase.search(by: "SHOW NOT FOUND") { (models: [Show]) in
                expect(models).to(beEmpty())
                done()
            }
        }
    }
}
