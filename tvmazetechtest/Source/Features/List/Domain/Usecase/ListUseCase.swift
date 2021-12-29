//
//  ListUseCase.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

class ListUseCase: InjectableComponent {
    @Inject
    private var repository: ListRepository?

    func fetch(by page: Int = 0) async -> [Show] {
        guard let response = await self.repository?.fetch(by: page) else { return [] }
        return response
    }

    func search(by query: String? = nil) async -> [Show] {
        guard let response = await self.repository?.search(by: query) else { return [] }
        return response
    }
}
