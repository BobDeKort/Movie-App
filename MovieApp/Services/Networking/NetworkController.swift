//
//  APIController.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/21/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

enum APIError: Swift.Error {
    case responseError
    case parseError
    case urlError
}

enum Result<T> {
    case success(T)
    case failure(APIError)
}

class NetworkController {
    static let shared = NetworkController()
    
    // ----------------------------------------
    // MARK: Public methods
    // ----------------------------------------
    
    public func getMovieBy(id: Int, completion: @escaping (Result<Movie>) -> () ) {
        
        guard let url = URL(string: "\(Constants.baseURL)movie/\(id)?api_key=\(Constants.apiKey)")  else {
            completion(Result.failure(.urlError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.executeRequest(request: request) { (data, error) in
            completion(self.parseMovie(data: data, error: error))
        }
    }
    
    public func searchForMovie(query: String, page: Int, completion: @escaping (Result<MoviesPage>) -> ()) {
        let optEncodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let encodedQuery = optEncodedQuery,
              let url = URL(string: "\(Constants.baseURL)search/movie?api_key=\(Constants.apiKey)&page=\(page)&query=\(encodedQuery)") else {
            completion(Result.failure(.urlError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.executeRequest(request: request) { (data, error) in
            completion(self.parseMoviePages(data: data, error: error))
        }
    }
    
    public func getGenresList(completion: @escaping (Result<[Genre]>) -> ()) {
        guard let url = URL(string: "\(Constants.baseURL)genre/movie/list?api_key=\(Constants.apiKey)") else {
            completion(Result.failure(.urlError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.executeRequest(request: request) { (data, error) in
            completion(self.parseGenresList(data: data, error: error))
        }
    }
    
    public func getImageFrom(path: String, type: Imagetype, completion: @escaping (Result<UIImage>) -> ()) {
        guard let url = self.getImageUrl(path: path, type: type) else {
            completion(Result.failure(.urlError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.executeRequest(request: request) { (data, error) in
            completion(self.parseImage(data: data, error: error))
        }
    }
    
    // ----------------------------------------
    // MARK: Parsing
    // ----------------------------------------
    
    private func parseMovie(data: Data?, error: Error?) -> Result<Movie> {
        guard let data = data, error == nil else {
            return Result.failure(.responseError)
        }
        
        if let movie = self.decodeData(data, type: Movie.self) as? Movie {
            return Result.success(movie)
        } else {
            return Result.failure(.parseError)
        }
    }
    
    private func parseMoviePages(data: Data?, error: Error?) -> Result<MoviesPage> {
        guard let data = data, error == nil else {
            return Result.failure(.responseError)
        }
        
        if let moviePage = self.decodeData(data, type: MoviesPage.self) as? MoviesPage {
            return Result.success(moviePage)
        } else {
            return Result.failure(.parseError)
        }
    }
    
    private func parseGenresList(data: Data?, error: Error?) -> Result<[Genre]> {
        guard let data = data, error == nil else {
            return Result.failure(.responseError)
        }
        
        if let genresList = self.decodeData(data, type: [String: [Genre]].self) as? [String: [Genre]] {
            if let genres = genresList["genres"] {
                return Result.success(genres)
            } else {
                return Result.failure(.parseError)
            }
        } else {
            return Result.failure(.parseError)
        }
    }
    
    private func parseImage(data: Data?, error: Error?) -> Result<UIImage> {
        guard let data = data, error == nil else {
            return Result.failure(.responseError)
        }
        if let image = UIImage(data: data) {
            return Result.success(image)
        } else {
            return Result.failure(.parseError)
        }
    }
    
    // ----------------------------------------
    // MARK: Private methods
    // ----------------------------------------
    
    private func decodeData<T: Decodable>(_ data: Data, type: T.Type) -> Any? {
        let decoder = JSONDecoder()
        
        var returnData: Any?
        do {
            returnData = try decoder.decode(type, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key \(key) was not found in: \(context)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("Type \(type) was not found in: \(context)")
        } catch {
            print(error)
        }
        
        return returnData
    }
 
    private func executeRequest(request: URLRequest, completion: @escaping (Data?, Error?) -> ()){
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard error == nil else {
                print("ERROR: ------------------------")
                print(error)
                completion(nil, error)
                return
            }
            
            if let data = data {
                completion(data, nil)
            }
        }).resume()
    }
    
    private func getImageUrl(path: String, type: Imagetype) -> URL? {
        if let url = URL(string: "\(Constants.baseImageUrl)\(type.imageSize())\(path)") {
            return url
        }
        return nil
    }
}

enum Imagetype {
    case poster
    case backdrop
    
    public func imageSize() -> String {
        switch self {
        case .poster:
            return "w500"
        case .backdrop:
            return "w300"
        }
    }
}
