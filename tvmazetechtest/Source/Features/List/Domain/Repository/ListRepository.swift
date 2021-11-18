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

    func fetch(by page: Int = 0, completion: @escaping ([Show]) -> Void) {
        let isFirstPage = self.isFirst(page: page)
        self.remote.get(to: "shows", with: PageRequest(page: page)) { (result: Result<[Show], BaseError>) in
            switch result {
            case .success(let response):
                let model = StoredShows(models: response)
                self.store.save(model, needRestore: isFirstPage)
                completion(response)

            case .failure(let error):
                CoreLog.business.error("%@", error.description)
                guard isFirstPage else { completion([]); return }
                let storedModels: [Show] = self.store.retrieve()?.models ?? []
                completion(storedModels)
            }
        }
    }

    func search(by query: String? = nil, completion: @escaping ([Show]) -> Void) {
        self.remote.get(to: "search/shows", with: SearchRequest(query: query)) { (result: Result<[SearchResponse], BaseError>) in
            switch result {
            case .success(let response):
                let shows: [Show] = self.getShowsSortedByName(response)
                let model = StoredShows(models: shows)
                self.store.save(model)
                completion(shows)

            case .failure(let error):
                CoreLog.business.error("%@", error.description)
                completion([])
            }
        }
    }
}

extension ListRepository {
    private func isFirst(page: Int) -> Bool {
        return page == 0
    }

    private func getShowsSortedByName(_ response: [SearchResponse]) -> [Show] {
        var shows = response.compactMap { $0.show }
        shows.sort(by: { $0.name < $1.name })
        return shows
    }
}
