//
//  ObservableTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class ObservableTests: XCTestCase {

    func testObservableSuccessful() {
        let object: Observable<Bool> = Observable<Bool>()

        defer {
            object.unsubscribe()
        }

        object.subscribe { value in
            expect(value).to(beTrue())
        }
        object.value = true
    }
}
