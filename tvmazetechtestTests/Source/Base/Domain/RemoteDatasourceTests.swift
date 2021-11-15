//
//  RemoteDatasourceTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class RemoteDatasourceTests: XCTestCase {

    @Inject
    private var remote: RemoteDatasource

    func testGetFirstPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.remote.get(to: "shows", with: PageRequest(page: 1)) { (result: Result<[Show], BaseError>) in
                switch result {
                case .success(let response):
                    expect(response).toNot(beNil())
                    done()
                case .failure(let error):
                    CoreLog.remote.error("%@", error.description)
                }
            }
        }
    }

    func testGetFirstPageFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            self.remote.get(to: "shows", with: PageRequest(page: 1)) { (result: Result<[String], BaseError>) in
                switch result {
                case .success(let response):
                    CoreLog.remote.debug("%@", response.testDescription)
                case .failure(let error):
                    expect(error).toNot(beNil())
                    done()
                }
            }
        }
    }
}
