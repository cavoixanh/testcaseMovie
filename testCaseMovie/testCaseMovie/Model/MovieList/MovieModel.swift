//
//  MovieModel.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MovieModel : NSObject {
    var vote_count : Int = 0
    var id: Int64 = 0
    var video: Bool = false
    var vote_average : Float = 0
    var title: String = ""
    //let popularity : Float32
    var poster_path : String = ""
    var original_language : String = ""
    var original_title : String = ""
    var backdrop_path : String = ""
    var adult : Bool = false
    var overview : String = ""
    var release_date : String = ""
    
    init(dict: Any) {
        if let data = dict as? [String: Any] {
            vote_count   = Int(data["vote_count"] as? Int ?? 0)
            id   = Int64((data["id"] as? Int64) ?? -1)
            video   = (data["video"] as? Bool ?? false)
            vote_average = (data["vote_average"] as? Float ?? 0)
            title = (data["title"] as? String ?? "")
            poster_path = (data["poster_path"] as? String ?? "")
            original_language = (data["original_language"] as? String ?? "")
            original_title = (data["original_title"] as? String ?? "")
            backdrop_path = (data["backdrop_path"] as? String ?? "")
            adult = data["adult"] as? Bool ?? false
            overview = data["overview"] as? String ?? ""
            release_date = data["release_date"] as? String ?? ""
            
        }
        
    }
}

class MovieRealmModel : Object {
    @objc dynamic var vote_count = 0
    @objc dynamic var id = 0
    @objc dynamic var video = false
    @objc dynamic var vote_average  = 0.0
    @objc dynamic var title = ""
    @objc dynamic var poster_path  = ""
    @objc dynamic var original_language  = ""
    @objc dynamic var original_title  = ""
    @objc dynamic var backdrop_path  = ""
    @objc dynamic var adult  = false
    @objc dynamic var overview  = ""
    @objc dynamic var release_date  = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(dict: MovieModel) {
        self.init()
        
        self.id = Int((dict.id))
        self.title = dict.title
        self.adult = dict.adult
        self.vote_count = dict.vote_count
        self.video = dict.video
        self.vote_average = Double(dict.vote_average)
        self.poster_path = dict.poster_path
        self.original_language = dict.original_language
        self.original_title = dict.original_title
        self.backdrop_path = dict.backdrop_path
        self.overview = dict.overview
        self.release_date = dict.release_date
        
    }
    
    required init() {
        super.init()
        //fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
        //fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
        //super.init()
        //fatalError("init(value:schema:) has not been implemented")
    }
}
