//
//  APIService.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import AlamofireImage
import RxSwift
import SwiftyJSON
import ObjectMapper
import Default

class APIService {
    static let shared = APIService()
    
    func requestImage(path: String, completionHandler: @escaping (UIImage) -> Void){
        AlamofireManager.manager.request("\(path)").responseImage(imageScale: 1.0, inflateResponseImage: false, completionHandler: {response in
            guard let image = response.result.value else{
                print("download\(path)->\(response.result)")
                return
            }
            DispatchQueue.main.async {
                completionHandler(image)
            }
        })
    }
    
    static func fetchMovieList(page: Int) -> Observable<MovieListModel> {
        return Observable.create{ observer in
            
            let headers = [
                "Content-Type": "application/json",
            ]
            
            let requestURL:String = Endpoints.MovieList.fetch.url + "&page=\(page)"
            
            let _ = AlamofireManager.manager.request(requestURL, method: .put, parameters:[:], encoding: JSONEncoding.default, headers:headers)
                .responseJSON{response in
                    
                    //checkRequestCode("CustomerProfile - ChangeProfile",response)
                    
                    switch response.result {
                    case .success:
                        let json = JSON(response.result.value!)
                        
                        let jsonData = "\(json)".data(using: .utf8)!
                        let decoder = JSONDecoder()
                        do{
                            let movieList = try decoder.decode(MovieListModel.self, from: jsonData)
                            if page == 1 {
                                self.removeCacheData()
                            }
                            self.saveDataListMovieToLocal(model: movieList)
                            observer.onNext(movieList)
                            observer.onCompleted()
                        } catch{
                            print(response.result.value!)
                        }
                    case .failure(let error):
                        if error._code == NSURLErrorTimedOut {
                            //                            forcedToast(ErrorTimeoutMessageLocalization)
                            return
                        }
                        print(error)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create(with: {
                
            })
        }
    }
    
    static func fetchMovieDetail(movieID:Int32) -> Observable<MovieListModel> {
        return Observable.create{ observer in
            
            let headers = [
                "Content-Type": "application/json",
                ]
            
            let requestURL:String = Endpoints.MovieDetail.fetch.url + "/\(movieID)" + "?api_key=\(API.apiKey)"
            
            let _ = AlamofireManager.manager.request(requestURL, method: .put, parameters:[:], encoding: JSONEncoding.default, headers:headers)
                .responseJSON{response in
                    
                    //checkRequestCode("CustomerProfile - ChangeProfile",response)
                    
                    switch response.result {
                    case .success:
                        print(response.result.value!)
                        let json = JSON(response.result.value!)
                        
                        let jsonData = "\(json)".data(using: .utf8)!
                        let decoder = JSONDecoder()
                        let movieList = try! decoder.decode(MovieListModel.self, from: jsonData)
                        
                        //let userdefault = UserDefaults.standard
                        //userdefault.set(json.rawString(), forKey: "CustomerProfile")
                        
                        observer.onNext(movieList)
                        observer.onCompleted()
                    case .failure(let error):
                        if error._code == NSURLErrorTimedOut {
                            //                            forcedToast(ErrorTimeoutMessageLocalization)
                            return
                        }
                        print(error)
                        observer.onError(error)
                    }
            }
            
            return Disposables.create(with: {
                
            })
        }
    }
    
    static func saveDataListMovieToLocal(model:MovieListModel){
        if let arr = UserDefaults.standard.df.fetch(forKey: Constant.LIST_MOVIE_DATA, type: [MovieModel].self) {
            let tempArray = arr + model.results
            UserDefaults.standard.df.store(tempArray, forKey: Constant.LIST_MOVIE_DATA)
        }else{
            UserDefaults.standard.df.store(model.results, forKey: Constant.LIST_MOVIE_DATA)
        }
    }
    
    static func getDataListMovieFromLocal() -> Observable<[MovieModel]> {
    
        return Observable.create{ observer in
    
            if let arr = UserDefaults.standard.df.fetch(forKey: Constant.LIST_MOVIE_DATA, type: [MovieModel].self) {
                observer.onNext(arr)
            }else{
                observer.onNext([])
            }
            observer.onCompleted()
            return Disposables.create(with: {
    
            })
        }
    }
    
    static func removeCacheData(){
        UserDefaults.standard.removeObject(forKey: Constant.LIST_MOVIE_DATA)
    }
}

class AlamofireManager{
    class var manager:Alamofire.SessionManager {
        
        let customManager = Alamofire.SessionManager.default
        customManager.session.configuration.timeoutIntervalForRequest = TimeInterval(Constant.Request_Timeout)
        
        
        //Bypass SSL Cert error
        //remove this in production for security risk
        //start
        customManager.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    
                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }
            
            return (disposition, credential)
        }
        //end
        
        return customManager
    }
}

