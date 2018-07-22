//
//  MovieCellViewModel.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

class MovieCellViewModel {
    
    // ----------------------------------------------------
    // MARK: - Constants
    // ----------------------------------------------------
    
    static let movieCellId = "movieCell"
    static let favoritesDidChange = Notification.Name("favoritesDidChange")
    
    // ----------------------------------------------------
    // MARK: - Stored properties
    // ----------------------------------------------------
    
    private var _movie: Movie
    
    // ----------------------------------------------------
    // MARK: - Computed properties
    // ----------------------------------------------------
    
    public var id: Int {
        return self._movie.id
    }
    
    public var movie: Movie {
        return self._movie
    }
    
    public var title: String {
        return self._movie.title
    }
    
    public var rating: Double {
        return self._movie.popularity
    }
    
    public var posterPath: String? {
        return self._movie.posterPath
    }
    
    public var isFavorited: Bool {
        return FavoritesController.shared.isFavorited(self._movie.id)
    }
    
    // ----------------------------------------------------
    // MARK: - Initializer
    // ----------------------------------------------------
    
    init(movie: Movie) {
        self._movie = movie
    }
    
    // ----------------------------------------------------
    // MARK: - User interaction methods
    // ----------------------------------------------------
    
    public func toggleFavorited() {
        if self.isFavorited {
            FavoritesController.shared.addFavorite(self._movie.id)
        } else {
            FavoritesController.shared.removeFavorite(self._movie.id)
        }
        NotificationCenter.default.post(name: MovieCellViewModel.favoritesDidChange, object: self)
    }
}
