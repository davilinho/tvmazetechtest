//
//  ResolverObjectMockTest.swift
//  tvmazetechtestTests
//
//  Created by David Martin on 15/11/21.
//

@testable import tvmazetechtest
import Foundation

class ResolverObjectMockTest: InjectableComponent {
    let value: String?

    init(value: String?) {
        self.value = value
    }
}
