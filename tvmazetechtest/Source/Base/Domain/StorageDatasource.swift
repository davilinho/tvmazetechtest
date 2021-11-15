//
//  StorageDatasource.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

@propertyWrapper
struct StorageDatasource<T: Codable> {
    private let key: String

    public init() {
        self.key = String(describing: T.self)
    }

    public var wrappedValue: T? {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data,
                let value = try? JSONDecoder().decode(T.self, from: data) else { return nil }
            return value
        }
        set {
            guard let newValue = newValue, let value = try? JSONEncoder().encode(newValue) else {
                UserDefaults.standard.removeObject(forKey: self.key)
                return
            }
            UserDefaults.standard.set(value, forKey: self.key)
        }
    }
}
