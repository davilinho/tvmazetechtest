//
//  ListViewModel.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

class ListViewModel: InjectableComponent & BaseViewModel {
    @Inject
    private var useCase: ListUseCase

    private var currentPage: Int = 0

    var isLoading: Bool = true
    var models = Observable<[Show]>()

    func onViewDidAppear() {
        self.resetPage()
        self.useCase.fetch() { [weak self] in
            guard let self = self else { return }
            self.update(models: $0)
        }
    }

    func fecthNext() {
        self.setIsLoading()
        self.increasePage()
        self.useCase.fetch(by: self.currentPage) { [weak self] in
            guard let self = self else { return }
            self.update(models: $0)
        }
    }

    func search(by query: String? = nil) {
        self.resetPage()
        self.useCase.search(by: query) { [weak self] in
            guard let self = self else { return }
            self.update(models: $0.compactMap { $0.show })
        }
    }

    private func setIsLoading() {
        self.isLoading = true
    }

    private func resetPage() {
        self.currentPage = 0
    }

    private func increasePage() {
        self.currentPage += 1
    }

    private func update(models: [Show]) {
        self.isLoading = false
        self.models.value = models
    }
}
