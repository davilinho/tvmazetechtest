//
//  PageRequest.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

struct PageRequest: Codable {
    let page: Int?

    enum CodingKeys: String, CodingKey {
        case page
    }
}
