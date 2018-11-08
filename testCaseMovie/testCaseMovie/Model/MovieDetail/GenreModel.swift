//
//  GenreModel.swift
//  testCaseMovie
//
//  Created by admin on 10/31/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class GenreModel: NSObject {
    var name: String = ""
    
    init(dict: Any) {
        if let data = dict as? [String: Any] {
            name = data["name"] as? String ?? ""
        }
    }
}
