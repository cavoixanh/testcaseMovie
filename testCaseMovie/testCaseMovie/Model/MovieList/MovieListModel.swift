//
//  MovieListModel.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MovieListModel : NSObject {
    var page: Int32 = 0
    let total_results : Int64 = 0
    let total_pages : Int64 = 0
    var results : [MovieModel] = []
    
    init(dict: Any) {
        if let data = dict as? [String: Any] {
            page = data["page"] as? Int32 ?? 0
            if let tempResults = data["results"] as? NSArray {
                for item in tempResults {
                    let model = MovieModel(dict: item)
                    results.append(model)
                }
            }
        }
    }
    
}
