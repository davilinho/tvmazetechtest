//
//  SearchRequest.swift
//  tvmazetechtest
//
//  Created by David Martin on 16/11/21.
//

import Foundation

struct SearchRequest: Codable {
    let query: String?

    enum CodingKeys: String, CodingKey {
        case query = "q"
    }
}
