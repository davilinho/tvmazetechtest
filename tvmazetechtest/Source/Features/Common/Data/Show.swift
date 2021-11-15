//
//  Show.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Foundation

struct Show: Codable {
    let url: String?
    let name: String?
    let rating: Rating?
    let summary: String?

    enum CodingKeys: String, CodingKey {
        case url
        case name
        case rating
        case summary
    }
}

struct Rating: Codable {
    let average: Double?

    enum CodingKeys: String, CodingKey {
        case average
    }
}
