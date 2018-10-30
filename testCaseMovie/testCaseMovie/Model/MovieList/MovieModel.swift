//
//  MovieModel.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

struct MovieModel : Codable {
    let vote_count : Int?
    let id: Int?
    let video: Bool
    let vote_average : Float?
    let title: String?
    //let popularity : Float32
    let poster_path : String?
    let original_language : String?
    let original_title : String?
    let backdrop_path : String?
    let adult : Bool
    let overview : String?
    let release_date : String?
    
    enum CodingKeys : String, CodingKey {
        case title = "title"
        case poster_path = "poster_path"
        case original_language = "original_language"
        case original_title = "original_title"
        case backdrop_path = "backdrop_path"
        case overview = "overview"
        case release_date = "release_date"
        case vote_count
        case id
        case video
        case vote_average
        case adult
    }
}
