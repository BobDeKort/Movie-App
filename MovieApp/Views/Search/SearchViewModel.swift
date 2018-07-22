//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

class SearchViewModel {
    static let searchResultsDidChange = Notification.Name("SearchViewModelResultsDidChange")
    
    // ----------------------------------------------------
    // MARK: - Stored properties
    // ----------------------------------------------------
    
    private var movies = [Movie]()
    private var moviesPage: MoviesPage? {
        didSet {
            if let moviesPage = self.moviesPage {
                if !isEditingMoviesPage {
                    self.movies = moviesPage.movies
                }
            } else {
                self.movies = []
            }
        }
    }
    /*
     NOTE: Was encountering some unwanted behaviour in the DidSet when I wanted to increase the page number. Because I did not have as much time to solve this oversight I used below variable to simplify the implementation
     */
    private var isEditingMoviesPage: Bool = false
    // TODO: Handle errors
    private var error: APIError?
    private var currentQuery: String?
    public var isPageRefreshing: Bool = false
    
    
    // ----------------------------------------------------
    // MARK: - Computed properties
    // ----------------------------------------------------
    
    public var numberOfMovies: Int {
        print("Count: \(movies.count)")
        return movies.count
    }
    
    // ----------------------------------------------------
    // MARK: - Getter/ Setter methods
    // ----------------------------------------------------
    
    public func cellViewModelFor(indexPath: IndexPath) -> MovieCellViewModel? {
        print("Count: \(movies.count)")
        print("index: \(indexPath.row)")
        return MovieCellViewModel(movie: self.movies[indexPath.row])
    }
    
    public func detailViewModelFor(indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(movie: self.movies[indexPath.row])
    }
    
    // ----------------------------------------------------
    // MARK: - Data manipulation methods
    // ----------------------------------------------------
    
    public func getResults(query: String, isNextPage: Bool) {
        // On an empty query clear the table view
        guard query != "" else {
            self.moviesPage = nil
            NotificationCenter.default.post(name: SearchViewModel.searchResultsDidChange, object: self)
            return
        }
        
        self.currentQuery = query
        self.isPageRefreshing = true
        let page = isNextPage ? (self.moviesPage?.page)! + 1 : 1
        
        NetworkController.shared.searchForMovie(query: query, page: page) { (result) in
            switch result {
            case let .success(page):
                // Checking if this is the first page loaded
                if self.moviesPage == nil {
                    self.moviesPage = page
                    self.moviesPage?.query = query
                } else {
                    // If its the same query we know its a following page
                    if self.moviesPage?.query != query {
                        self.movies = []
                        self.moviesPage = page
                        self.isEditingMoviesPage = true
                        self.moviesPage?.query = query
                        self.isEditingMoviesPage = false
                    } else {
                        self.isEditingMoviesPage = true
                        self.moviesPage?.query = query
                        self.moviesPage?.totalPages = page.totalPages
                        self.moviesPage?.totalResults = page.totalResults
                        self.isEditingMoviesPage = false
                        self.movies.append(contentsOf: page.movies)
                    }
                }
            case let .failure(type):
                self.error = type
            }

            self.isPageRefreshing = false
            // Notification to reload tableview
            NotificationCenter.default.post(name: SearchViewModel.searchResultsDidChange, object: self)
        }
    }
    
    public func getNextResults() {
        // Making sure there is a movies page and that page has a page number
        if self.moviesPage != nil, self.moviesPage!.page != nil {
            // Checking if this is the last available page
            if self.moviesPage!.page! < self.moviesPage!.totalPages! {
                // Safe unwrapping the previous query
                if let query = self.currentQuery {
                    // increasing the page number and getting the next page
                    self.isEditingMoviesPage = true
                    self.moviesPage!.page! += 1
                    self.isEditingMoviesPage = false
                    self.getResults(query: query, isNextPage: true)
                }
            }
        }
    }
}
