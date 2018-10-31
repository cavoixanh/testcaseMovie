//
//  MovideDetailModel.swift
//  testCaseMovie
//
//  Created by admin on 10/31/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

struct MovideDetailModel: Codable {
    let genres : [GenreModel]?
    let backdrop_path : String?
    let production_companies : [CompanyModel]?
    let budget : Float64?
    let revenue: Float64?
    let original_language : String?
    let title  : String?
    let tagline: String?
    let overview : String?
    let poster_path: String?
    let release_date : String?
    let id: Int64?
    
}
