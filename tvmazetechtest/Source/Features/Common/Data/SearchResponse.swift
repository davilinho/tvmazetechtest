//
//  SearchResponse.swift
//  tvmazetechtest
//
//  Created by David Martin on 16/11/21.
//

import Foundation

struct SearchResponse: Codable {
    public enum CodingKeys: String, CodingKey {
        case show
    }

    let show: Show
}
