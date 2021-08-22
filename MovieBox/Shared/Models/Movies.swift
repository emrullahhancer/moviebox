//
//  Movies.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 21.08.2021.
//

import Foundation

struct Movies: Codable {
    var results: [MoviesResults]?
}

struct MoviesResults: Codable {
    var bannerImage, title, overview, posterImage, date, imdb_id: String?
    var id: Int?
    var vote: Double?
    
    enum CodingKeys: String, CodingKey {
        case bannerImage = "backdrop_path"
        case posterImage = "poster_path"
        case date = "release_date"
        case id
        case title, overview, imdb_id
        case vote = "vote_average"
    }
}
