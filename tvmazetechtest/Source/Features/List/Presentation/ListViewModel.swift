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
        self.useCase?.fetch { [weak self] in
            guard let self = self else { return }
            self.deactiveLoading()
            self.set(models: $0)
        }
    }

    private func paginationFetch() {
        self.useCase?.fetch(by: self.currentPage) { [weak self] in
            guard let self = self else { return }
            self.deactiveLoading()
            self.add(models: $0)
        }
    }

    private func searchFetch(by query: String?) {
        self.useCase?.search(by: query) { [weak self] in
            guard let self = self else { return }
            self.deactiveLoading()
            self.set(models: $0)
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
