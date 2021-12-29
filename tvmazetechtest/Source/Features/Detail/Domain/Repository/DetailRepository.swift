//
//  DetailRepository.swift
//  tvmazetechtest
//
//  Created by David Martin on 16/11/21.
//

import Foundation

class DetailRepository: InjectableComponent {
    @Inject
    private var remote: RemoteDatasource?

    @Inject
    private var store: StoreShowsDatasource?

    func fetch(by id: Int) async -> Show? {
        guard let storedModel = self.retrieveFromStorage(by: id) else {
            return await self.fetchFromRemote(by: id)
        }
        return storedModel
    }
}

// MARK: - Private functions

extension DetailRepository {
    private func retrieveFromStorage(by id: Int) -> Show? {
        guard let storedModels = self.store?.retrieve(), let model = storedModels.models.filter({ $0.id == id }).first else { return nil }
        return model
    }

    private func fetchFromRemote(by id: Int) async -> Show? {
        let url = ["shows", id.description].joined(separator: "/")
        do {
            guard let response: Show = try await self.remote?.get(to: url, with: nil) else { return nil }
            let model = StoredShows(models: [response])
            self.store?.save(model)
            return response
        } catch {
            CoreLog.business.error("%@", error.localizedDescription)
            let storedModel = self.store?.retrieve()?.models.filter { $0.id == id }.first
            return storedModel
        }
    }
}
