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
            Task {
                if let models: [Show] = await self.listUseCase?.fetch(), !models.isEmpty {
                    let model: Show? = await self.detailUseCase?.fetch(by: 1)
                    expect(model).toNot(beNil())
                    done()
                }
            }
        }
    }

    func testGetDetailFromRemoteSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                let model: Show? = await self.detailUseCase?.fetch(by: 1)
                expect(model).toNot(beNil())
                expect(model?.id).to(equal(1))
                done()
            }
        }
    }
}
