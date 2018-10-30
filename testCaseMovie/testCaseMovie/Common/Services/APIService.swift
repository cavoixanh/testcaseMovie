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
import RxSwift
import SwiftyJSON
import ObjectMapper

class APIService {
    static let shared = APIService()
    
//    func requestImage(path: String, completionHandler: @escaping (UIImage) -> Void){
//        AlamofireManager.manager.request("\(path)").responseImage(imageScale: 1.0, inflateResponseImage: false, completionHandler: {response in
//            guard let image = response.result.value else{
//                print("download\(path)->\(response.result)")
//                return
//            }
//            DispatchQueue.main.async {
//                completionHandler(image)
//            }
//        })
//    }
    
    static func fetchMovieList() -> Observable<MovieListModel> {
        return Observable.create{ observer in
            
            let headers = [
                "Content-Type": "application/json",
            ]
            
            let requestURL:String = Endpoints.MovieList.fetch.url
            
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

