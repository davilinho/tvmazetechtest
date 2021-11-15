//
//  ListViewModelTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class ListViewModelTests: XCTestCase {

    @Inject
    private var viewModel: ListViewModel

    func testGetFirstPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.viewModel.models.subscribe { models in
                expect(models).toNot(beNil())
                done()
            }
            self.viewModel.onViewDidAppear()
        }
    }

    func testGetSecondPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.viewModel.models.subscribe { models in
                expect(models).toNot(beNil())
                done()
            }
            self.viewModel.fecthNext(page: 1)
        }
    }

    func testGetPageOutOfRangeFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.viewModel.models.subscribe { models in
                expect(models).to(beEmpty())
                done()
            }
            self.viewModel.fecthNext(page: 100000000)
        }
    }

    func testGetSearchSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.viewModel.models.subscribe { models in
                expect(models).toNot(beNil())
                done()
            }
            self.viewModel.search(by: "Cars")
        }
    }

    func testGetSearchFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.viewModel.models.subscribe { models in
                expect(models).to(beEmpty())
                done()
            }
            self.viewModel.search(by: "SHOW NOT FOUND")
        }
    }
}
