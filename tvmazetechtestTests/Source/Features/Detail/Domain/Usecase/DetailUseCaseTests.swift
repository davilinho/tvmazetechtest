//
//  DetailUseCaseTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 16/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class DetailUseCaseTests: XCTestCase {
    @Inject
    private var listUseCase: ListUseCase?

    @Inject
    private var detailUseCase: DetailUseCase?

    @Inject
    private var store: StoreShowsDatasource?

    override func setUp() {
        super.setUp()
        self.store?.clear()
    }

    func testGetDetailFromStoreSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.listUseCase?.fetch { (models: [Show]) in
                if !models.isEmpty {
                    self.detailUseCase?.fetch(by: 1) { (model: Show?) in
                        expect(model).toNot(beNil())
                        done()
                    }
                }
            }
        }
    }

    func testGetDetailFromRemoteSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.detailUseCase?.fetch(by: 1) { (model: Show?) in
                expect(model).toNot(beNil())
                expect(model?.id).to(equal(1))
                done()
            }
        }
    }
}
