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

    func testViewControllerFetch() {
        guard let sut = self.loadView() else { return }
        sut.viewDidAppear(true)
        expect(self.spy.onFetchCalled).to(beTrue())
    }

    func testViewControllerAssertSnapshotSuccessful() {
        guard let sut = self.loadView() else { return }
        sut.viewDidLoad()
        assertSnapshot(matching: sut, as: .image)
    }

    func testViewControllerSearch() {
        guard let sut = self.loadView() else { return }
        let searchBar: UISearchBar = UISearchBar()
        searchBar.text = "Cards"
        sut.searchBar(searchBar, textDidChange: "")
        sut.enableFilter(searchBar)
        expect(self.spy.onSearchCalled).to(beTrue())
    }

    func testViewControllerSearchNotFound() {
        guard let sut = self.loadView() else { return }
        let searchBar: UISearchBar = UISearchBar()
        searchBar.text = "SHOW NOT FOUND"
        sut.searchBar(searchBar, textDidChange: "")
        sut.enableFilter(searchBar)
        expect(self.spy.onSearchCalled).to(beTrue())
    }

    func testViewControllerCancelSearch() {
        guard let sut = self.loadView() else { return }
        let searchBar: UISearchBar = UISearchBar()
        searchBar.text = "Cards"
        sut.searchBarCancelButtonClicked(searchBar)
        expect(self.spy.onFetchCalled).to(beTrue())
    }
}

extension ListViewControllerTests {
    private func loadView() -> ListViewController? {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "List", bundle: bundle)
        guard let sut: ListViewController = storyboard.instantiateViewController(withIdentifier: "List") as? ListViewController else { return nil }
        sut.loadView()
        sut.viewModel = spy
        return sut
    }
}
