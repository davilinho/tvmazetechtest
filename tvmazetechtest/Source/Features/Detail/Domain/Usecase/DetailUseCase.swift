//
//  DetailUseCase.swift
//  tvmazetechtest
//
//  Created by David Martin on 16/11/21.
//

import Foundation

class DetailUseCase: InjectableComponent {
    @Inject
    private var repository: DetailRepository?

    func fetch(by id: Int) async -> Show? {
        guard let response = await self.repository?.fetch(by: id) else { return nil }
        return response
    }
}
