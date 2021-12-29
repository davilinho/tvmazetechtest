//
//  ListRepository.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

class ListRepository: InjectableComponent {
    @Inject
    private var remote: RemoteDatasource?

    @Inject
    private var store: StoreShowsDatasource?

    func fetch(by page: Int = 0) async -> [Show] {
        let isFirstPage = self.isFirst(page: page)
        do {
            guard let response: [Show] = try await self.remote?.get(to: "shows", with: PageRequest(page: page)) else { return [] }
            let model = StoredShows(models: response)
            self.store?.save(model, needRestore: isFirstPage)
            return response
        } catch {
            CoreLog.business.error("%@", error.localizedDescription)
            guard isFirstPage else { return [] }
            let storedModels: [Show] = self.store?.retrieve()?.models ?? []
            return storedModels
        }
    }

    func search(by query: String? = nil) async -> [Show] {
        do {
            guard let response: [SearchResponse] = try await self.remote?.get(to: "search/shows", with: SearchRequest(query: query)) else { return [] }
            let shows: [Show] = self.getShowsSortedByName(response)
            let model = StoredShows(models: shows)
            self.store?.save(model)
            return shows
        } catch {
            CoreLog.business.error("%@", error.localizedDescription)
            return []
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
