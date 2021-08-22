//
//  DetailViewModel.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 22.08.2021.
//

import Foundation

class DetailViewModel {
    
    var apiManager = APIManager.shared
    
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
    
    var movie: MoviesResults? {
        didSet {
            self.reloadDataClosure?()
        }
    }
    
    func getNowPlaying(id: Int) {
        self.state = .loading
        apiManager.getMovie(id: "\(id)") { movie in
            self.state = .populated
            self.movie = movie
        } callbackFailure: { err in
            self.state = .populated
        }

    }
}
