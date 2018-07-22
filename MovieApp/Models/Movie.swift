//
//  Movie.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/21/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let runtime: Int?
    let genres: [Genre]?
    let genreIDs: [Int]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case popularity
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case runtime
        case genres
        case genreIDs = "genre_ids"
    }
}

public struct MoviesPage: Codable {
    var movies = [Movie]()
    var page: Int?
    var totalPages: Int?
    var totalResults: Int?
    var query: String?
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
