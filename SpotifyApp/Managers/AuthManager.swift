//
//  AuthManager.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 29.7.21..
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    //MARK: - Init
    
    private init() { }
    
    //MARK: - Public
    
    struct Constants {
        static let clientID = "8b314b360b3e4751b1b843c9b4b01eda"
        static let clientSecret = "3fdbe91a80e64ac689eecbd2d6efa5d6"
    }
    
    var isSingedIn: Bool {
        return false
    }
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://www.spotify.com/us/home/"
        let base = "https://accounts.spotify.com/authorize?"
        let url = "\(base)response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: url)
    }
    
    public func excangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        // Get token
    }
    
    public func refreshAccessToken() {
        
    }
    
    //MARK: - Private
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
