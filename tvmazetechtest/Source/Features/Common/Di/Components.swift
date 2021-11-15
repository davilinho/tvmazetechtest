//
//  Components.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

class Components {
    static func initInjections() {
        Resolver.shared.add(type: RemoteDatasource.self, { return RemoteDatasource() })
    }
}
