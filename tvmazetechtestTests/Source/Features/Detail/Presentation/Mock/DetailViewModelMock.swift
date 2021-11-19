//
//  DetailViewModelMock.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 16/11/21.
//

@testable import tvmazetechtest
import Foundation

class DetailViewModelMock: DetailViewModel {
    private(set) var onFetchCalled = false

    override func fetch(by: Int) {
        self.onFetchCalled = true
    }
}
