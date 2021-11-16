//
//  ListViewModelMock.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import Foundation

class ListViewModelMock: ListViewModel {
    private(set) var onViewAppearCalled = false
    private(set) var onFetchNextCalled = false
    private(set) var onSearchCalled = false

    override func onViewDidAppear() {
        self.onViewAppearCalled = true
    }

    override func fetchNext() {
        self.onFetchNextCalled = true
    }

    override func search(by query: String? = nil) {
        self.onSearchCalled = true
    }
}
