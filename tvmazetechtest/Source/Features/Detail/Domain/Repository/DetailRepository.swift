//
//  DetailRepository.swift
//  tvmazetechtest
//
//  Created by David Martin on 16/11/21.
//

import Foundation

class DetailRepository: InjectableComponent {
    @Inject
    private var remote: RemoteDatasource

    @Inject
    private var store: StoreShowsDatasource

    func fetch(by id: Int, completion: @escaping (Show?) -> Void) {
        guard let storedModel = self.retrieveFromStorage(by: id) else {
            self.fetchFromRemote(by: id, completion: completion)
            return
        }
        completion(storedModel)
    }
}

// MARK: - Private functions

extension DetailRepository {
    private func retrieveFromStorage(by id: Int) -> Show? {
        guard let storedModels = self.store.retrieve(), let model = storedModels.models.filter({ $0.id == id }).first else { return nil }
        return model
    }

    private func fetchFromRemote(by id: Int, completion: @escaping (Show?) -> Void) {
        let url = ["shows", id.description].joined(separator: "/")
        self.remote.get(to: url, with: nil) { (result: Result<Show, BaseError>) in
            switch result {
            case .success(let response):
                let model = StoredShows(models: [response])
                self.store.save(model)
                completion(response)
            case .failure(let error):
                CoreLog.business.error("%@", error.description)
                self.store.clear()
                completion(nil)
            }
        }
    }
}
