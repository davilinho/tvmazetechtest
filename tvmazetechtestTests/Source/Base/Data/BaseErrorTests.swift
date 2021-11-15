//
//  BaseErrorTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class BaseErrorTests: XCTestCase {

    func testRepositoryErrorReasonDescription() {
        let error: BaseError = BaseError.repositoryError(.reason("TEST"))
        expect(error.description).to(equal("RepositoryError - Reason: TEST"))
    }

    func testRemoteErrorReasonDescription() {
        let error: BaseError = BaseError.remoteError(.reason("TEST"))
        expect(error.description).to(equal("RemoteError - Reason: TEST"))
    }

    func testUiErrorReasonDescription() {
        let error: BaseError = BaseError.ui(.reason("TEST"))
        expect(error.description).to(equal("UIError - Reason: TEST"))
    }
}
