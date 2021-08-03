//
//  File.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 1.8.21..
//

import Foundation

struct FeaturedPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

