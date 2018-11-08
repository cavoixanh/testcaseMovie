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

let minHeightCell = 163

class MovieListViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var disposeBag = DisposeBag()
    var movieModelArray : [MovieModel] = []
    var reloadTableViewBlock : (()->())?
    var didSelectModelBlock : ((MovieModel)->())?
    var page : Int = 1
    var isOfflineMode = true
    
    static let movieListViewModel = MovieListViewModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModelArray.count ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        cell.minHeight = CGFloat(minHeightCell)
        cell.setMovieModel(aMovieModel: (movieModelArray[indexPath.row]))
        if  indexPath.row == ((movieModelArray.count) - 3){
            page+=1
            fetchData()
        }
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
    
    func fetchData(){
//        if isOfflineMode {
//            APIService.getDataListMovieFromLocal().subscribe(
//                onNext: {(movieList) in
//                    self.movieModelArray = movieList
//                    if movieList.count > 0 && self.reloadTableViewBlock != nil{
//                        self.reloadTableViewBlock!()
//                    }
//
//                    if !Reachability.isConnectedToNetwork(){
//                        self.alertNetWork()
//                        return;
//                    }
//
//                    APIService.fetchMovieList(page: self.page).subscribe(
//                        onNext: {(dataModel) in
//
//                            if self.page == 1 {
//                                self.movieModelArray.removeAll()
//                            }
//                            self.isOfflineMode = false
//                            self.movieModelArray += dataModel.results
//
//                            if self.reloadTableViewBlock != nil{
//                                self.reloadTableViewBlock!()
//                            }
//                    },
//                        onError: {(error) in
//                            self.isOfflineMode = true
//                            self.alertNetWork()
//                    },
//                        onCompleted: {
//
//                    }).disposed(by: self.disposeBag)
//            },
//                onError: {(error) in
//
//            },
//                onCompleted: {
//
//            }).disposed(by: disposeBag)
//        }else{
        
            APIService.fetchMovieList(page: self.page).subscribe(
                onNext: {(dataModel) in
                    self.movieModelArray += dataModel.results
                    
                    if self.reloadTableViewBlock != nil{
                        self.reloadTableViewBlock!()
                    }
                    
            },
                onError: {(error) in
                    self.isOfflineMode = true
                    self.alertNetWork()
            },
                onCompleted: {
                    
            }).disposed(by: self.disposeBag)
        //}
   }
    
    func alertNetWork(){
        let alert = UIAlertController(title: "Warning", message: "Lost network connection", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
            self.fetchData()
        }))
        let window :UIWindow = UIApplication.shared.keyWindow!
        window.rootViewController!.present(alert, animated: true, completion: nil)
    }
}
