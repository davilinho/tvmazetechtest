//
//  DetailUseCase.swift
//  tvmazetechtest
//
//  Created by David Martin on 16/11/21.
//

import Foundation

class DetailUseCase: InjectableComponent {
    @Inject
    private var repository: DetailRepository?

    func fetch(by id: Int, completion: @escaping (Show?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.repository?.fetch(by: id) { response in
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        }
    }
}
