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
        factoryDict[String(describing: type.self)] = factory
    }

    func resolve<InjectableComponent>(_ type: InjectableComponent.Type) -> InjectableComponent {
        let component: InjectableComponent =
            factoryDict[String(describing: InjectableComponent.self)]?() as! InjectableComponent
        return component
    }
}
