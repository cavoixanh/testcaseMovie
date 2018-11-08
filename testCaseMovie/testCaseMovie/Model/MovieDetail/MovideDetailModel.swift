//
//  MovideDetailModel.swift
//  testCaseMovie
//
//  Created by admin on 10/31/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MovideDetailModel: NSObject {
    var genres : [GenreModel] = []
    var backdrop_path : String = ""
    var production_companies : [CompanyModel] = []
    var budget : Float64 = 0
    var revenue: Float64 = 0
    var original_language : String = ""
    var title  : String = ""
    var tagline: String = ""
    var overview : String = ""
    var poster_path: String = ""
    var release_date : String = ""
    var id: Int64 = 0
    var runtime: Int64 = 0
 
    init(dict: Any) {
        if let data = dict as? [String: Any] {
            if let tempResults = data["genres"] as? NSArray {
                for item in tempResults {
                    let model = GenreModel(dict: item)
                    genres.append(model)
                }
            }
            
            backdrop_path = data["backdrop_path"] as? String ?? ""
            if let tempResults2 = data["production_companies"] as? NSArray {
                for item in tempResults2 {
                    let model2 = CompanyModel(dict: item)
                    production_companies.append(model2)
                }
            }
            budget = data["budget"] as? Float64 ?? 0
            revenue = data["revenue"] as? Float64 ?? 0
            original_language = data["original_language"] as? String ?? ""
            title = data["title"] as? String ?? ""
            tagline = data["tagline"] as? String ?? ""
            overview = data["overview"] as? String ?? ""
            poster_path = data["poster_path"] as? String ?? ""
            release_date = data["release_date"] as? String ?? ""
            id = data["id"] as? Int64 ?? 0
            runtime = data["runtime"] as? Int64 ?? 0
        }
    }
}
