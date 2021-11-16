//
//  ListRepository.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

class ListRepository: InjectableComponent {
    @Inject
    private var remote: RemoteDatasource

    @StorageDatasource
    private var storedShows: StoredShows?

    func fetch(by page: Int? = 0, completion:  @escaping ([Show]) -> Void) {
        self.remote.get(to: "shows", with: PageRequest(page: page)) { (result: Result<[Show], BaseError>) in
            switch result {
            case .success(let response):
                CoreLog.business.info("%@", response)
                self.store(models: response, needRestore: page == 0)
                completion(response)
            case .failure(let error):
                CoreLog.business.error("%@", error.description)
                self.clear()
                completion([])
            }
        }
    }

    func search(by query: String? = nil, completion:  @escaping ([SearchResponse]) -> Void) {
        self.remote.get(to: "search/shows", with: SearchRequest(query: query)) { (result: Result<[SearchResponse], BaseError>) in
            switch result {
            case .success(let response):
                CoreLog.business.info("%@", response)
                self.store(models: response.compactMap { $0.show })
                completion(response)
            case .failure(let error):
                CoreLog.business.error("%@", error.description)
                self.clear()
                completion([])
            }
        }
    }
}

// MARK: - Local store management

extension ListRepository {
    private func store(models: [Show], needRestore: Bool = true) {
        if needRestore {
            self.save(models)
        } else {
            self.append(models)
        }
    }

    private func save(_ models: [Show]) {
        if self.storedShows == nil {
            self.storedShows = StoredShows()
        }
        self.storedShows?.models = models
    }

    private func append(_ models: [Show]) {
        if self.storedShows == nil {
            self.storedShows = StoredShows()
        }
        self.storedShows?.models.append(contentsOf: models)
    }

    private func clear() {
        self.storedShows?.models = []
    }
}
