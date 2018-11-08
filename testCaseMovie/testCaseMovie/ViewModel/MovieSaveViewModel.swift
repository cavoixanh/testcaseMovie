//
//  MovieSaveViewModel.swift
//  testCaseMovie
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import UIKit


class MovieSaveViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    var movieModelArray : [MovieRealmModel] = []
    var didSelectModelBlock : ((MovieRealmModel)->())?
    
    static let movieSaveViewModel = MovieSaveViewModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModelArray.count ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        cell.minHeight = CGFloat(minHeightCell)
        cell.setMovieRealmModel(aMovieModel: (movieModelArray[indexPath.row]))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.didSelectModelBlock != nil {
            self.didSelectModelBlock!(movieModelArray[indexPath.row])
        }
    }
}
