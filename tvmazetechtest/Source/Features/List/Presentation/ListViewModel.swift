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

    var models = Observable<[Show]>()

    func onViewDidAppear() {
        self.useCase.fetch() { [weak self] in
            guard let self = self else { return }
            self.update(models: $0)
        }
    }

    func fecthNext(page: Int) {
        self.useCase.fetch(by: page) { [weak self] in
            guard let self = self else { return }
            self.update(models: $0)
        }
    }

    func search(by query: String? = nil) {
        self.useCase.search(by: query) { [weak self] in
            guard let self = self else { return }
            self.update(models: $0.compactMap { $0.show })
        }
    }

    private func update(models: [Show]) {
        self.models.value = models
    }
}
