//
//  Codable+Extension.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

extension Encodable {
    public var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
