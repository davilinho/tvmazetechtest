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

    func fetch(by page: Int? = 0, completion:  @escaping ([Show]) -> Void) {
        self.remote.get(to: "shows", with: PageRequest(page: page)) { (result: Result<[Show], BaseError>) in
            switch result {
            case .success(let response):
                CoreLog.business.info("%@", response)
                completion(response)
            case .failure(let error):
                CoreLog.business.error("%@", error.description)
                completion([])
            }
        }
    }
}
