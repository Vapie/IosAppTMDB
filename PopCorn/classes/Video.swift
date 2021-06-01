//
//  Video.swift
//  PopCorn
//
//  Created by Vqpie on 01/06/2021.
//

import Foundation

// MARK: - Welcome
struct APIResponseVideo: Codable {
    let id: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id, iso639_1, iso3166_1, key: String
    let name, site: String
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
