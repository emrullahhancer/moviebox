//
//  HomeViewModel.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 21.08.2021.
//

import Foundation

final class HomeViewModel {
    var apiManager = APIManager.shared
    var page = 1
    var reloadDataClosure: (() -> Void)?
    
    var state: State? {
        didSet {
            switch state {
            case .loading:
                Loader.show()
            default:
                Loader.hide()
            }
        }
    }
    
    var nowPlaying: [MoviesResults]? {
        didSet {
            self.reloadDataClosure?()
        }
    }
    var upComing: [MoviesResults]? = [] {
        didSet {
            self.reloadDataClosure?()
        }
    }
    
    func getNowPlaying(showLoading: Bool = true) {
        if showLoading {
            self.state = .loading
        }
        apiManager.getMovies(path: "now_playing") { movies in
            self.nowPlaying = movies.results?.filter( { $0.vote != nil } )
            self.state = .populated
        } callbackFailure: { err in
            self.state = .populated
        }
    }
    
    func getUpcoming(showLoading: Bool = true) {
        if showLoading {
            self.state = .loading
        }
        apiManager.getMovies(path: "upcoming", page: self.page) { movies in
            if self.page == 1 {
                self.upComing?.removeAll()
            }
            if let results = movies.results {
                self.upComing?.append(contentsOf: results)
            }
            self.state = .populated
        } callbackFailure: { err in
            self.state = .populated
        }
    }
}
