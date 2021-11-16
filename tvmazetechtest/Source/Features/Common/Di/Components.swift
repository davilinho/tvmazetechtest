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
        Resolver.shared.add(type: StoreShowsDatasource.self, { return StoreShowsDatasource() })
        Resolver.shared.add(type: ListRepository.self, { return ListRepository() })
        Resolver.shared.add(type: ListUseCase.self, { return ListUseCase() })
        Resolver.shared.add(type: ListViewModel.self, { return ListViewModel() })
    }
}
