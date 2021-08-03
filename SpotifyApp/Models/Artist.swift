//
//  Artist.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 29.7.21..
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}

