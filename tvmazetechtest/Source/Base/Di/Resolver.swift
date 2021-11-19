//
//  Resolver.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

protocol InjectableComponent: AnyObject {}

class Resolver {
    static let shared = Resolver()

    var factoryDict: [String: () -> InjectableComponent] = [:]

    func add(type: InjectableComponent.Type, _ factory: @escaping () -> InjectableComponent) {
        self.factoryDict[String(describing: type.self)] = factory
    }

    // swiftlint:disable force_cast
    func resolve<InjectableComponent>(_ type: InjectableComponent.Type) -> InjectableComponent? {
        guard let component: InjectableComponent = self.factoryDict[String(describing: InjectableComponent.self)]?() as? InjectableComponent else { return nil }
        return component
    }
}
