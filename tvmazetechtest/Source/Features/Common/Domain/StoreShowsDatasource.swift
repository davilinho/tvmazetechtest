//
//  StoreShowsDatasource.swift
//  tvmazetechtest
//
//  Created by David Martin on 16/11/21.
//

import Foundation

class StoreShowsDatasource: InjectableComponent {
    private var storeDatasource: StoreDatasource<StoredShows> = {
        return StoreDatasource<StoredShows>()
    }()

    func retrieve() -> StoredShows? {
        return self.storeDatasource.retrieve()
    }

    func save(_ model: StoredShows, needRestore: Bool = true) {
        if needRestore {
            self.storeDatasource.save(value: model)
        } else {
            if self.storeDatasource.retrieve() == nil {
                self.storeDatasource.save(value: StoredShows())
            }

            guard var storedModels = self.storeDatasource.retrieve() else { return }
            storedModels.models.append(contentsOf: model.models)
            self.storeDatasource.save(value: storedModels)
        }
    }

    func clear() {
        self.storeDatasource.clear()
    }
}
