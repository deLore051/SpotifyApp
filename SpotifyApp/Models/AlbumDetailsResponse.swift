//
//  AlbumDetailsResponse.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 3.8.21..
//

import Foundation

struct AlbumDetailsResponse: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let total_tracks: Int
    let tracks: TracksResponse
}

struct TracksResponse: Codable {
    let items: [AudioTrack]
}
