//
//  DetailViewModelTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 16/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class DetailViewModelTests: XCTestCase {

    @Inject
    private var viewModel: DetailViewModel

    func testGetDetailSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.viewModel.model.subscribe { model in
                expect(model).toNot(beNil())
                done()
            }
            self.viewModel.fetch(by: 1)
        }
    }

    func testGetDetailFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.viewModel.model.subscribe { model in
                expect(model).to(beNil())
                done()
            }
            self.viewModel.fetch(by: 100000000)
        }
    }
}
