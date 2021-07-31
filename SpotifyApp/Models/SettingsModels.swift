//
//  SettingsModels.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 30.7.21..
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
