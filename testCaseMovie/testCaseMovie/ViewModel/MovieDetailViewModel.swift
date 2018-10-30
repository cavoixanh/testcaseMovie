//
//  MovieDetailViewModel.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {

    var disposeBag = DisposeBag()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9 ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        cell.minHeight = CGFloat(minHeightCell)
//        cell.setMovieModel(aMovieModel: (movieModelArray[indexPath.row]))
//        if !isOfflineMode && indexPath.row == ((movieModelArray.count) - 3){
//            page+=1
//            fetchData()
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
