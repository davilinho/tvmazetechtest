//
//  Observable.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

class Observable<T> {
    typealias Observer = (T?) -> Void

    private var observer: Observer?

    var value: T? {
        didSet {
            self.observer?(self.value)
        }
    }

    init() {
        self.value = nil
    }

    init(_ value: T) {
        self.value = value
    }

    func subscribe(_ observer: Observer?) {
        self.observer = observer
    }

    func unsubscribe() {
        self.observer = nil
    }
}
