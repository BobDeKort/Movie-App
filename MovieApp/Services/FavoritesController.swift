//
//  FavoritesController.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/21/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

class FavoritesController {
    static let shared = FavoritesController()
    
    // ----------------------------------------
    // MARK: Stored properties
    // ----------------------------------------
    
    private let favoritesIDsKey = "Favorites"
    private var favoritesIDs = [Int]() {
        didSet {
            if oldValue.count < self.favoritesIDs.count {
                self.fetchFavoriteMovies()
            }
        }
    }
    private var movies = [Movie]()
    private var apiError: APIError?
    
    // ----------------------------------------
    // MARK: Computed properties
    // ----------------------------------------
    
    public var favoriteMovies: [Movie] {
        return self.movies
    }
    
    public func initiate() {
        self.loadLocalIDs()
    }
    
    // ----------------------------------------
    // MARK: Local ID storage
    // ----------------------------------------
    
    // Retrieves stored ids from user defaults
    private func loadLocalIDs() {
        let array = UserDefaults.standard.array(forKey: self.favoritesIDsKey)
        self.favoritesIDs = array as? [Int] ?? [Int]()
    }
    
    // Stores all current favorites ids to local storage
    private func saveFavorites() {
        DispatchQueue.main.async {
            UserDefaults.standard.set(self.favoritesIDs, forKey: self.favoritesIDsKey)
        }
    }
    
    // Public function to check if a movie is favorited
    public func isFavorited(_ id: Int) -> Bool {
        for favorite in self.favoritesIDs {
            if favorite == id {
                return true
            }
        }
        return false
    }
    
    // Public function to add a favorites id
    public func addFavorite(_ id: Int) {
        self.favoritesIDs.append(id)
        self.fetchNewFavoriteMovie(id)
        self.saveFavorites()
    }
    
    // Public function to remove a favorites id
    public func removeFavorite(_ id: Int) {
        for (index, favorite) in self.favoritesIDs.enumerated() {
            if favorite == id {
                self.favoritesIDs.remove(at: index)
                self.movies.remove(at: index)
                NotificationCenter.default.post(name: FavoritesViewModel.favoritesDidChange, object: self)
            }
        }
        self.saveFavorites()
    }
    
    // ----------------------------------------
    // MARK: API methods
    // ----------------------------------------
    
    private func fetchFavoriteMovies() {
        if !self.favoritesIDs.isEmpty {
            self.movies = []
            for id in self.favoritesIDs {
                self.fetchNewFavoriteMovie(id)
            }
        } else {
            self.loadLocalIDs()
        }
    }
    
    private func fetchNewFavoriteMovie(_ id: Int) {
        NetworkController.shared.getMovieBy(id: id) { (result) in
            switch result {
            case let .success(movie):
                self.movies.append(movie)
            case let .failure(type):
                self.apiError = type
            }
            NotificationCenter.default.post(name: FavoritesViewModel.favoritesDidChange, object: self)
        }
    }
}
