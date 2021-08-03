//
//  NewRelesesResponse.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 1.8.21..
//

import Foundation

struct NewRelesesResponse: Codable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

