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
    private var useCase: ListUseCase?

    func testGetFirstPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                let models: [Show]? = await self.useCase?.fetch()
                expect(models).toNot(beNil())
                done()
            }
        }
    }

    func testGetSecondPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                let models: [Show]? = await self.useCase?.fetch(by: 1)
                expect(models).toNot(beNil())
                done()
            }
        }
    }

    func testGetPageOutOfRangeFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                let models: [Show]? = await self.useCase?.fetch(by: 100000000)
                expect(models).to(beEmpty())
                done()
            }
        }
    }

    func testGetSearchSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                let models: [Show]? = await self.useCase?.search(by: "Cars")
                expect(models).toNot(beNil())
                done()
            }
        }
    }

    func testGetSearchFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                let models: [Show]? = await self.useCase?.search(by: "SHOW NOT FOUND")
                expect(models).to(beEmpty())
                done()
            }
        }
    }
}
