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
    var movieDetailModel : MovideDetailModel?
    var reloadTableViewBlock : (()->())?
    
    static let movieDetailViewModel = MovieDetailViewModel()
    
    func fetchDetail(aMovieID: Int32){
        
        APIService.fetchMovieDetail(movieID: aMovieID).subscribe(
            onNext: {(dataModel) in
                self.movieDetailModel = dataModel
                if self.reloadTableViewBlock != nil {
                    self.reloadTableViewBlock!()
                }
        },
            onError: {(error) in
            
                let _ = APIService.fetchMovieDetail(movieID: aMovieID).subscribe(onNext: { (dataModel) in
                    self.movieDetailModel = dataModel
                    if self.reloadTableViewBlock != nil {
                        self.reloadTableViewBlock!()
                    }
                }, onError: {(error) in
                    
                    }, onCompleted: {
                        
                }, onDisposed: {
                    
                })
        },
            onCompleted: {
                
        }).disposed(by: self.disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (movieDetailModel != nil) ? 9 : 0 ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHeaderCell", for: indexPath) as! DetailHeaderCell
            cell.setMovieDetail(aMovieDetail: self.movieDetailModel!)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailContentCell", for: indexPath) as! DetailContentCell
        cell.indexPath = indexPath
        cell.setMovieDetail(aMovieDetail: self.movieDetailModel!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        if indexPath.row == 0 {
            return 175
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
