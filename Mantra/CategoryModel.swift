//
//  CategoryModel.swift
//  Mantra
//
//  Created by Sudhakar on 10/01/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import Foundation

// MARK: - WelcomeElement
struct Category: Codable {
    let name: String
    let subCategory: [SubCategory]

    enum CodingKeys: String, CodingKey {
        case name
        case subCategory = "sub_category"
    }
}

// MARK: - SubCategory
struct SubCategory: Codable {
    let name, displayName: String

    enum CodingKeys: String, CodingKey {
        case name
        case displayName = "display_name"
    }
}

//typealias Welcome = [WelcomeElement]

