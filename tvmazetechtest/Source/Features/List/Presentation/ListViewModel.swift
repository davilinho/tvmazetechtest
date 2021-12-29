//
//  ListViewModel.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

class ListViewModel: InjectableComponent & BaseViewModel {
    @Inject
    private var useCase: ListUseCase?

    private (set) var isLoading: Bool = true
    private (set) var models = Observable<[Show]>([])
    private (set) var detailId = Observable<Int>()

    private var currentPage: Int = 0

    func fetch() {
        self.resetPage()
        self.initialFetch()
    }

    func fetchNext() {
        self.activeLoading()
        self.increasePage()
        self.paginationFetch()
    }

    func search(by query: String? = nil) {
        self.resetPage()
        self.searchFetch(by: query)
    }

    func didSelect(by id: Int) {
        self.select(by: id)
    }
}

// MARK: - Private logic

extension ListViewModel {
    private func initialFetch() {
        Task {
            guard let response = await self.useCase?.fetch() else { return }
            self.deactiveLoading()
            self.set(models: response)
        }
    }

    private func paginationFetch() {
        Task {
            guard let response = await self.useCase?.fetch(by: self.currentPage) else { return }
            self.deactiveLoading()
            self.add(models: response)
        }
    }

    private func searchFetch(by query: String?) {
        Task {
            guard let response = await self.useCase?.search(by: query) else { return }
            self.deactiveLoading()
            self.set(models: response)
        }
    }

    private func select(by id: Int) {
        self.detailId.value = id
    }

    private func activeLoading() {
        self.isLoading = true
    }

    private func deactiveLoading() {
        self.isLoading = false
    }

    private func resetPage() {
        self.currentPage = 0
    }

    private func increasePage() {
        self.currentPage += 1
    }

    private func set(models: [Show]) {
        self.models.value = models
    }

    private func add(models: [Show]) {
        self.models.value?.append(contentsOf: models)
    }
}
