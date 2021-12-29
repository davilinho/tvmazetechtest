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
    private var remote: RemoteDatasource?

    func testGetFirstPageSuccessful() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                if let response: [Show] = try await self.remote?.get(to: "shows", with: PageRequest(page: 1)) {
                    expect(response).toNot(beNil())
                    done()
                }
            }
        }
    }

    func testGetFirstPageFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                do {
                    if let response: [String] = try await self.remote?.get(to: "shows", with: PageRequest(page: 1)) {
                        CoreLog.remote.debug("%@", response.testDescription)
                    }
                } catch {
                    expect(error).toNot(beNil())
                    done()
                }
            }
        }
    }

    func testGetPageOutOfRangeFailure() {
        waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
            Task {
                do {
                    if let response: [Show] = try await self.remote?.get(to: "shows", with: PageRequest(page: 100000000)) {
                        CoreLog.remote.debug("%@", response.testDescription)
                    }
                } catch {
                    expect(error).toNot(beNil())
                    done()
                }
            }
        }
    }
}
