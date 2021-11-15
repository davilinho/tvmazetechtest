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
}
