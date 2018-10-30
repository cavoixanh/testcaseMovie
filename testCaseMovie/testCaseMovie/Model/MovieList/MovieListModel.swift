//
//  MovieListModel.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

struct MovieListModel : Codable {
    let page: Int32
    let total_results : Int64
    let total_pages : Int64
    var results : [MovieModel]
}
