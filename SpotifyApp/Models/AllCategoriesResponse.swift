//
//  AllCategoriesResponse.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 6.8.21..
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}


