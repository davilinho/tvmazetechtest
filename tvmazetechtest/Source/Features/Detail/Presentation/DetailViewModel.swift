//
//  DetailViewModel.swift
//  tvmazetechtest
//
//  Created by David Martin on 16/11/21.
//

import Foundation

class DetailViewModel: InjectableComponent & BaseViewModel {
    @Inject
    private var useCase: DetailUseCase?

    private (set) var model = Observable<Show>()

    func fetch(by id: Int) {
        self.useCase?.fetch(by: id) { [weak self] model in
            guard let self = self else { return }
            self.model.value = model
        }
    }
}
