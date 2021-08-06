//
//  APICaller.swift
//  SpotifyApp
//
//  Created by Stefan Dojcinovic on 29.7.21..
//

import Foundation


final class APICaller {
    
    static let shared = APICaller()
    
    private init() { }
    
    struct Constants {
        static let baseAPIurl = "https://api.spotify.com/v1/"
        static let newReleasesAPI = "browse/new-releases?limit=50"
        static let featuredAlbumsAPI = "browse/featured-playlists?limit=50"
        static let recomendationsAPI = "recommendations?limit=20&seed_genres="
        static let recomendedGenresAPI = "recommendations/available-genre-seeds"
        static let albumDetailsAPI = "albums/"
        static let playlistDetailsAPI = "playlists/"
        static let categoriesAPI = "browse/categories"
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    
    
    //MARK: - Public
    
    /// Get album details that are going to be presented in the AlbumVC when user opens a specific abum from browse or library
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIurl + Constants.albumDetailsAPI + album.id),
                      type: .GET) { [weak self] request in
            guard self != nil else { return }
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    /// Get playlist details that are going to be presented in the PlaylistVC when user opens a specific playlist from browse or library
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIurl + Constants.playlistDetailsAPI + playlist.id),
                      type: .GET) { [weak self] request in
            guard self != nil else { return }
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    /// Get data for the current profile with an API call
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIurl + "me"),
                      type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    /// Get new releases data with an API call
    public func getNewReleases(completion: @escaping ((Result<NewRelesesResponse, Error>) -> Void)) {
        createRequest(with: URL(string: Constants.baseAPIurl + Constants.newReleasesAPI),
                      type: .GET) { [weak self] request in
            guard self != nil else { return }
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewRelesesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    /// Get featured playlists data with an API call
    public func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistResponse, Error>) -> Void)) {
        createRequest(with: URL(string: Constants.baseAPIurl + Constants.featuredAlbumsAPI),
                      type: .GET) { [weak self] request in
            guard self != nil else { return }
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    /// Get recommended tracks and artists based from seed artists, genres and tracks with an API call
    public func getRecomendedTracks(genres: Set<String>,
                                    completion: @escaping ((Result<RecommendedTrackResponse, Error>) -> Void)) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIurl + Constants.recomendationsAPI + seeds),
                      type: .GET) { [weak self] request in
            guard self != nil else { return }
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedTrackResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    /// Get recommeded genres from spotify with an API call
    public func getRecomendedGenres(completion: @escaping ((Result<RecommendedGenresResponse, Error>) -> Void)) {
        createRequest(with: URL(string: Constants.baseAPIurl + Constants.recomendedGenresAPI ),
                      type: .GET) { [weak self] request in
            guard self != nil else { return }
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    /// Get categories from spotify with an API call
    public func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIurl + Constants.categoriesAPI + "?limit=50&locale=en_us"),
                      type: .GET) { [weak self] request in
            guard self != nil else { return }
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    /// Get playlists from spotify category with an API call
    public func getCategoriePlaylists(category: Category, completion: @escaping (Result<[Playlist], Error>) -> Void) {
        let url = Constants.baseAPIurl + Constants.categoriesAPI + "/\(category.id)/playlists?limit=50&locale=en_us"
        createRequest(with: URL(string: url),
                      type: .GET) { [weak self] request in
            guard self != nil else { return }
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(CategoryPlaylistsResponse.self, from: data)
                    completion(.success(result.playlists.items))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Private
    
    /// Create a generic request that we can modify to call different API's
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping ((URLRequest) -> Void)) {
        AuthManager.shared.withValidToken { token in
            guard let url = url else { return }
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
