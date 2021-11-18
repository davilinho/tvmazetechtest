//
//  ComponentsTests.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import XCTest
import Nimble

class ComponentsTests: XCTestCase {

    func testRemoteDatasourceSuccessful() {
        expect(Resolver.shared.resolve(RemoteDatasource.self)).toNot(beNil())
        expect(Resolver.shared.resolve(RemoteDatasource.self)).to(beAKindOf(RemoteDatasource.self))
    }

    func testStoreShowsDatasourceSuccessful() {
        expect(Resolver.shared.resolve(StoreShowsDatasource.self)).toNot(beNil())
        expect(Resolver.shared.resolve(StoreShowsDatasource.self)).to(beAKindOf(StoreShowsDatasource.self))
    }

    func testListRepositorySuccessful() {
        expect(Resolver.shared.resolve(ListRepository.self)).toNot(beNil())
        expect(Resolver.shared.resolve(ListRepository.self)).to(beAKindOf(ListRepository.self))
    }

    func testListUseCaseSuccessful() {
        expect(Resolver.shared.resolve(ListUseCase.self)).toNot(beNil())
        expect(Resolver.shared.resolve(ListUseCase.self)).to(beAKindOf(ListUseCase.self))
    }

    func testListViewModelSuccessful() {
        expect(Resolver.shared.resolve(ListViewModel.self)).toNot(beNil())
        expect(Resolver.shared.resolve(ListViewModel.self)).to(beAKindOf(ListViewModel.self))
    }

    func testListWireframeSuccessful() {
        expect(Resolver.shared.resolve(ListWireframe.self)).toNot(beNil())
        expect(Resolver.shared.resolve(ListWireframe.self)).to(beAKindOf(ListWireframe.self))
    }

    func testDetailRepositorySuccessful() {
        expect(Resolver.shared.resolve(DetailRepository.self)).toNot(beNil())
        expect(Resolver.shared.resolve(DetailRepository.self)).to(beAKindOf(DetailRepository.self))
    }

    func testDetailUseCaseSuccessful() {
        expect(Resolver.shared.resolve(DetailUseCase.self)).toNot(beNil())
        expect(Resolver.shared.resolve(DetailUseCase.self)).to(beAKindOf(DetailUseCase.self))
    }

    func testDetailViewModelSuccessful() {
        expect(Resolver.shared.resolve(DetailViewModel.self)).toNot(beNil())
        expect(Resolver.shared.resolve(DetailViewModel.self)).to(beAKindOf(DetailViewModel.self))
    }
}
