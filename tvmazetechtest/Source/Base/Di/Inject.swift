//
//  Inject.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

@propertyWrapper
struct Inject<Component> {
    var component: Component?

    init() {
        self.component = Resolver.shared.resolve(Component.self)
    }

    public var wrappedValue: Component? {
        get { return component }
        mutating set { component = newValue }
    }
}
