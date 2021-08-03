//
//  User.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 1.8.21..
//

import Foundation

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
