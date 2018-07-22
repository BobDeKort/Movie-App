//
//  FavoritesViewModel.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/19/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

class FavoritesViewModel {
    
    static let favoritesDidChange = Notification.Name("favoriteMoviesDidChange")
    static let favoritesCellId = "movieCell"
    open var pageTitle: String = "Favorites"
    
    // ----------------------------------------------------
    // MARK: - Stored properties
    // ----------------------------------------------------
    
    public var numberOfMovies: Int {
        return self.favoriteMovies.count
    }
    
    public var favoriteMovies: [Movie] {
        return FavoritesController.shared.favoriteMovies
    }
    
    // ----------------------------------------------------
    // MARK: - Getter/ Setter methods
    // ----------------------------------------------------
    
    public func cellViewModelFor(indexPath: IndexPath) -> MovieCellViewModel? {
        return MovieCellViewModel(movie: self.favoriteMovies[indexPath.row])
    }
    
    public func detailViewModelFor(indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(movie: self.favoriteMovies[indexPath.row])
    }

}
