//
//  APIManager.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 21.08.2021.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    let baseUrl = "https://api.themoviedb.org/3/movie/"
    let key = "1aed6ff3dd63681df5342bf160a5d193"
    let imageUrl = "https://image.tmdb.org/t/p/w500/"
    
    typealias callbackSuccess = (Movies) -> Void
    typealias callbackFailure = (APIError) -> Void
    
    func getMovies(path: String, page: Int = 1, callbackSuccess: @escaping callbackSuccess, callbackFailure: @escaping callbackFailure) {
        guard var components = URLComponents(string: "\(baseUrl)\(path)") else { callbackFailure(.urlError)
            return
        }
        components.queryItems = [URLQueryItem(name: "api_key", value: key), URLQueryItem(name: "page", value: "\(page)")]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = components.url else {
            callbackFailure(.urlError)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                callbackFailure(.responseError)
                return
            }
            
            do {
                let responseConvert = try JSONDecoder().decode(Movies.self, from: jsonData)
                callbackSuccess(responseConvert)
            } catch {
                callbackFailure(.parseError)
            }
        }
        
        task.resume()
    }
    
    typealias callbackSuccessMovie = (MoviesResults) -> Void
    
    func getMovie(id: String, callbackSuccess: @escaping callbackSuccessMovie, callbackFailure: @escaping callbackFailure) {
        guard var components = URLComponents(string: "\(baseUrl)\(id)") else { callbackFailure(.urlError)
            return
        }
        components.queryItems = [URLQueryItem(name: "api_key", value: key)]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        guard let url = components.url else {
            callbackFailure(.urlError)
            return
        }
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                callbackFailure(.responseError)
                return
            }
            
            do {
                let responseConvert = try JSONDecoder().decode(MoviesResults.self, from: jsonData)
                callbackSuccess(responseConvert)
            } catch {
                callbackFailure(.parseError)
            }
        }
        
        task.resume()
    }
}
