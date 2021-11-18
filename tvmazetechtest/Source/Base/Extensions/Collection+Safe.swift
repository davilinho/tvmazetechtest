//
//  Collection+Safe.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

extension Collection {
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
