//
//  Enums.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 22.08.2021.
//

import Foundation


enum APIError: Error {
    case urlError
    case responseError
    case parseError
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum State {
    case empty
    case loading
    case populated
}
