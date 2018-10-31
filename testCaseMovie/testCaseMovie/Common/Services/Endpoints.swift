//
//  Endpoints.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

struct API {
    static let baseUrl = "https://api.themoviedb.org"
    static let apiKey = "14bc774791d9d20b3a138bb6e26e2579"
    static let imageThumnbUrl = "https://image.tmdb.org/t/p/w200"
    static let imageBackdropUrl = "https://image.tmdb.org/t/p/w500"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum MovieList: Endpoint {
        case fetch
        public var path: String {
            switch self {
            case .fetch: return "/3/discover/movie?api_key=\(API.apiKey)"
            }
        }
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
    enum MovieDetail: Endpoint {
        case fetch
        public var path: String {
            switch self {
            case .fetch: return "/3/movie"
            }
        }
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
}
