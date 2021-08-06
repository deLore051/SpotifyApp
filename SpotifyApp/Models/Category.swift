//
//  Category.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 6.8.21..
//

import Foundation

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
