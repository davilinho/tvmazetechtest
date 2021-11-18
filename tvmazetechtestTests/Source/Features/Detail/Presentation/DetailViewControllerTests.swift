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

    func testViewControllerFetchCalledSuccessful() {
        guard let sut = self.loadView() else { return }
        sut.id = 1
        sut.viewDidLoad()
        expect(self.spy.onFetchCalled).to(beTrue())
    }

    func testViewControllerFetchSuccessful() {
        guard let sut = self.loadViewWithoutMock() else { return }
        sut.id = 1
        sut.viewDidLoad()
        sut.bindViewModels()
        sut.viewModel.model.subscribe { response in
            expect(response).toNot(beNil())
        }
    }

    func testViewControllerFetchFailure() {
        guard let sut = self.loadView() else { return }
        sut.viewDidLoad()
        expect(self.spy.onFetchCalled).to(beFalse())
    }

    func testViewControllerAssertSnapshotSuccessful() {
        guard let sut = self.loadView() else { return }
        sut.viewDidLoad()
        assertSnapshot(matching: sut, as: .image)
    }

    func testFillDataWithRatingSuccessful() {
        guard let sut = self.loadViewWithoutMock() else { return }
        sut.bindViewModels()
        sut.viewModel.model.value = Show(id: 1, name: "TEST",
                                         image: Image(medium: "https://static.tvmaze.com/images/api/tvm_api.png", original: "https://static.tvmaze.com/images/api/tvm_api.png"),
                                         rating: Rating(average: 10), summary: "TEST")
        expect(sut.viewModel.model.value).notTo(beNil())
    }

    func testFillDataWithoutRatingSuccessful() {
        guard let sut = self.loadViewWithoutMock() else { return }
        sut.bindViewModels()
        sut.viewModel.model.value = Show(id: 1, name: "TEST",
                                         image: Image(medium: "https://static.tvmaze.com/images/api/tvm_api.png", original: "https://static.tvmaze.com/images/api/tvm_api.png"),
                                         rating: nil, summary: "TEST")
        expect(sut.viewModel.model.value).notTo(beNil())
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

    private func loadViewWithoutMock() -> DetailViewController? {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Detail", bundle: bundle)
        guard let sut: DetailViewController = storyboard.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return nil }
        sut.loadView()
        return sut
    }
}
