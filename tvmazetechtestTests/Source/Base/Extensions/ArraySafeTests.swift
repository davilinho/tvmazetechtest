//
//  ArraySafeTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class ArraySafeTests: XCTestCase {

    func testArraySafeSuccessful() {
        let array: [Int] = [1, 2, 3, 4, 5]
        expect(array[safe: 0]).to(equal(1))
    }
}
