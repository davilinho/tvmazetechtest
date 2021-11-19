//
//  ListWireframeTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 17/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class ListWireframeTests: XCTestCase {
    @Inject
    private var wireframe: ListWireframe?

    func testWireframeSuccessful() {
        self.wireframe?.navigate(to: .detail(by: 1), with: UINavigationController())
        expect(self.wireframe).toNot(beNil())
    }
}
