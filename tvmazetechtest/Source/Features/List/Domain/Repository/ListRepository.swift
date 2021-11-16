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

    @Inject
    private var store: StoreShowsDatasource

    func fetch(by page: Int? = 0, completion: @escaping ([Show]) -> Void) {
        self.remote.get(to: "shows", with: PageRequest(page: page)) { (result: Result<[Show], BaseError>) in
            switch result {
            case .success(let response):
                CoreLog.business.info("%@", response)

                let model = StoredShows(models: response)
                self.store.save(model, needRestore: page == 0)

                completion(response)
            case .failure(let error):
                CoreLog.business.error("%@", error.description)
                self.store.clear()
                completion([])
            }
        }
    }

    func search(by query: String? = nil, completion: @escaping ([SearchResponse]) -> Void) {
        self.remote.get(to: "search/shows", with: SearchRequest(query: query)) { (result: Result<[SearchResponse], BaseError>) in
            switch result {
            case .success(let response):
                let model = StoredShows(models: response.compactMap { $0.show })
                self.store.save(model)
                completion(response)
            case .failure(let error):
                CoreLog.business.error("%@", error.description)
                self.store.clear()
                completion([])
            }
        }
    }
}
