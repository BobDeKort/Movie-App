//
//  GenresController.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/21/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

class GenresController {
    private var _genres = [Int: String]()
    
    init() {
        self.updateGenres()
    }
    
    // ----------------------------------------
    // MARK: Public methods
    // ----------------------------------------
    
    public func getNameFor(id: Int) -> String? {
        guard !self._genres.isEmpty else {
            self.updateGenres()
            return nil
        }
        return self._genres[id]
    }
    
    public func getGenreFor(id: Int) -> Genre? {
        guard !self._genres.isEmpty else {
            self.updateGenres()
            return nil
        }

        return self._genres[id] != nil ? Genre(id: id, name: self._genres[id]!) : nil
    }
    
    // ----------------------------------------
    // MARK: Private methods
    // ----------------------------------------
    
    private func updateGenres() {
        NetworkController.shared.getGenresList { (result) in
            switch result {
            case let .success(genres):
                for genre in genres {
                    self._genres[genre.id] = genre.name
                }
            case let .failure(type):
                // TODO:
                print(type)
            }
        }
    }
}
