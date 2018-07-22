//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/19/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    // ----------------------------------------
    // MARK: Stored poperties
    // ----------------------------------------
    
    private var _movie: Movie
    
    // ----------------------------------------
    // MARK: Computed properties
    // ----------------------------------------
    
    public var movie: Movie {
        return self._movie
    }
    
    public var id: Int {
        return self._movie.id
    }
    
    public var posterPath: String? {
        return self._movie.posterPath
    }
    
    public var backdropPath: String? {
        return self._movie.backdropPath
    }
    
    public var runtime: Int? {
        return self._movie.runtime
    }
    
    // TODO: Genres
    
    public var rating: Double {
        return self._movie.popularity
    }
    
    public var title: String {
        return self._movie.title
    }
    
    public var overview: String {
        return self._movie.overview
    }
    
    public var isFavorited: Bool {
        return FavoritesController.shared.isFavorited(self._movie.id)
    }
    
    // ----------------------------------------
    // MARK: Initializers
    // ----------------------------------------
    
    init(movie: Movie) {
        self._movie = movie
    }
    
    // ----------------------------------------
    // MARK: Update methods
    // ----------------------------------------
    
    private func getFullMovie(id: Int?) {
        NetworkController.shared.getMovieBy(id: id ?? self._movie.id) { (result) in
            switch result {
            case let .success(movie):
                self._movie = movie
            case let .failure(type):
                // TODO: handle error
                print("ERROR: \(type)")
            }
        }
    }
}
