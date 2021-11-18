//
//  ListUseCase.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

class ListUseCase: InjectableComponent {
    @Inject
    private var repository: ListRepository

    func fetch(by page: Int = 0, completion:  @escaping ([Show]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.repository.fetch(by: page) { response in
                completion(response)
            }
        }
    }

    func search(by query: String? = nil, completion:  @escaping ([Show]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.repository.search(by: query) { response in
                completion(response)
            }
        }
    }
}
