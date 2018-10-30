//
//  MovieListViewModel.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

let minHeightCell = 148

class MovieListViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var disposeBag = DisposeBag()
    var movieListModel : MovieListModel?
    var reloadTableView : (()->())?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListModel?.results.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        cell.minHeight = CGFloat(minHeightCell)
        cell.setMovieModel(aMovieModel: (movieListModel?.results[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    static let movieListViewModel = MovieListViewModel()
    
    func fetchData(){
        APIService.fetchMovieList().subscribe(
            onNext: {(dataModel) in
                self.movieListModel = dataModel
                if self.reloadTableView != nil{
                    self.reloadTableView!()
                }
                
        },
            onError: {(error) in
                //self.state.value = .networkError
        },
            onCompleted: {
                //self.state.value = .unknownWord
        }).disposed(by: disposeBag)
    }
}
