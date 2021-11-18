//
//  StoreShowsDatasourceTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 16/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class StoreShowsDatasourceTests: XCTestCase {
    @Inject
    private var store: StoreShowsDatasource

    func testStoreShowsSuccessful() {
        self.store.save(StoredShows(models: [Show(id: 0, name: "TEST", image: nil, rating: nil, summary: nil)]), needRestore: true)
        expect(self.store.retrieve()).toNot(beNil())
    }

    func testClearShowsSuccessful() {
        self.store.clear()
        if let storedModel = self.store.retrieve() {
            expect(storedModel.models.count).to(equal(0))
        }
    }
}
