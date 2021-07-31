//
//  AuthManager.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 29.7.21..
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private var refreshingToken = false
    
    //MARK: - Init
    
    private init() { }
    
    struct Constants {
        static let clientID = "8b314b360b3e4751b1b843c9b4b01eda"
        static let clientSecret = "3fdbe91a80e64ac689eecbd2d6efa5d6"
        static let tokenAPIurl = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://www.spotify.com/us/home/"
        static let scopes = "user-read-private%20playlist-modify-public%20playlist-modify-private%20playlist-read-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize?"
        let url = "\(base)response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        return URL(string: url)
    }
    
    /// Use the code we get when we are signing in the app to exchange for a token
    public func excangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        // Get token
        guard let url = URL(string: Constants.tokenAPIurl) else { return }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Faliure to get base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    /// Check if token is still valid before further usage with API Calls
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            // Append the completion
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken {
            // Refresh
            refreshIfNeeded { [weak self] success in
                guard let self = self else { return }
                guard success, let token = self.accessToken else { return }
                completion(token)
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    /// Refresh access token few minutes before it expires so we dont start the process with dead token
    public func refreshIfNeeded(completion: ((Bool) -> Void)?) {
        guard !refreshingToken else { return }
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        guard let refreshToken = self.refreshToken else { return }
        
        // Refresh the token
        guard let url = URL(string: Constants.tokenAPIurl) else { return }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Faliure to get base64")
            completion?(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            self.refreshingToken = false
            guard let data = data, error == nil else {
                completion?(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.onRefreshBlocks.forEach { $0(result.access_token) }
                self.onRefreshBlocks.removeAll()
                self.cacheToken(result: result)
                completion?(true)
            } catch {
                print(error.localizedDescription)
                completion?(false)
            }
        }
        task.resume()
    }
    
    /// Cache the current access token for further usage
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(result.refresh_token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)),
                                       forKey: "expirationDate")
    }
    
    /// Return true or false depending if the user is signed in or not
    var isSingedIn: Bool {
        return accessToken != nil
    }
    
    /// Access token we get when we sign in successfuly, it lasts 60 minutes before we need a new one
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    /// Access token we get when we do a successful refresh with the current access token
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    /// Expiration date of the current access token
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    /// Checks how much time our current token has before we should refresh it
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
}
