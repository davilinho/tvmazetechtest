//
//  ListViewControllerTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 16/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble
import SnapshotTesting

class ListViewControllerTests: XCTestCase {
    let spy: ListViewModelMock = ListViewModelMock()

    func testViewControllerDidAppear() {
        guard let sut = self.loadView() else { return }
        sut.viewDidAppear(true)
        expect(self.spy.onViewAppearCalled).to(beTrue())
    }

    func testViewControllerAssertSnapshotSuccessful() {
        guard let sut = self.loadView() else { return }
        sut.viewDidLoad()
        assertSnapshot(matching: sut, as: .image)
    }
}

extension ListViewControllerTests {
    private func loadView() -> ListViewController? {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "List", bundle: bundle)
        guard let sut: ListViewController = storyboard.instantiateViewController(withIdentifier: "List") as? ListViewController else { return nil }
        sut.viewModel = spy
        return sut
    }
}
