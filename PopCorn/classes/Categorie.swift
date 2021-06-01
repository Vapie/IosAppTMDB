//
//  Categorie.swift
//  PopCorn
//
//  Created by Vqpie on 01/06/2021.
//

import Foundation

// MARK: - Welcome
struct APIResponseCategorie: Codable {
    let genres: [Categorie]
}

// MARK: - Categorie
struct Categorie: Codable {
    let id: Int
    let name: String
}
