//
//  ResolverTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class ResolverTests: XCTestCase {

    func testResolverSuccessful() {
        Resolver.shared.add(type: ResolverObjectMockTest.self, { return ResolverObjectMockTest(value: "TEST") })
        let object = Resolver.shared.resolve(ResolverObjectMockTest.self)
        expect(object).toNot(beNil())
        expect(object?.value).to(equal("TEST"))
    }
}
