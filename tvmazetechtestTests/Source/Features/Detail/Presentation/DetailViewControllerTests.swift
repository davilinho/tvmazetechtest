//
//  DetailViewControllerTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 17/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble
import SnapshotTesting

class DetailViewControllerTests: XCTestCase {
    let spy: DetailViewModelMock = DetailViewModelMock()

    func testViewControllerFetchSuccessful() {
        guard let sut = self.loadView() else { return }
        sut.id = 1
        sut.viewDidAppear(true)
        expect(self.spy.onFetchCalled).to(beTrue())
    }

    func testViewControllerFetchFailure() {
        guard let sut = self.loadView() else { return }
        sut.viewDidAppear(true)
        expect(self.spy.onFetchCalled).to(beFalse())
    }

    func testViewControllerAssertSnapshotSuccessful() {
        guard let sut = self.loadView() else { return }
        sut.viewDidLoad()
        assertSnapshot(matching: sut, as: .image)
    }
}

extension DetailViewControllerTests {
    private func loadView() -> DetailViewController? {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Detail", bundle: bundle)
        guard let sut: DetailViewController = storyboard.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return nil }
        sut.loadView()
        sut.viewModel = spy
        return sut
    }
}
