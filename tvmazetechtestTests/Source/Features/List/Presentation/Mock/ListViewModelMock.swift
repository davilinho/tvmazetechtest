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

    override func onViewDidAppear() {
        self.onViewAppearCalled = true
    }
}
