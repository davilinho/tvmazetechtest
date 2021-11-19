//
//  DetailRepositoryTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 16/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class DetailRepositoryTests: XCTestCase {
    @Inject
    private var listRepository: ListRepository?

    @Inject
    private var detailRepository: DetailRepository?

    @Inject
    private var store: StoreShowsDatasource?

    override func setUp() {
        super.setUp()
        self.store?.clear()
    }

    func testGetDetailFromStoreSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.listRepository?.fetch { (models: [Show]) in
                if !models.isEmpty {
                    self.detailRepository?.fetch(by: 1) { (model: Show?) in
                        expect(model).toNot(beNil())
                        expect(model?.id).to(equal(1))
                        done()
                    }
                }
            }
        }
    }

    func testGetDetailFromRemoteSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.detailRepository?.fetch(by: 1) { (model: Show?) in
                expect(model).toNot(beNil())
                expect(model?.id).to(equal(1))
                done()
            }
        }
    }
}
