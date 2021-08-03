//
//  UserProfile.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 29.7.21..
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let product: String
}

