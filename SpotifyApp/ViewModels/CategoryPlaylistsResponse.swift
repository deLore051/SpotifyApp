//
//  CategoryPlaylistsResponse.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 6.8.21..
//

import Foundation

struct CategoryPlaylistsResponse: Codable {
    let playlists: Playlists
}

struct Playlists: Codable {
    let items: [Playlist]
}

