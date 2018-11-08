//
//  MovieListViewController.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var splashImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getParam()
        
    }
    
    func configTableView(){
        tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
        tableView.delegate = MovieListViewModel.movieListViewModel
        tableView.dataSource = MovieListViewModel.movieListViewModel
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func setUpUI(){
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x273446)
        self.navigationController?.navigationBar.topItem?.title = "Movie List"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.addLeftIcon()
    }
    
    func addLeftIcon(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(menuAction))
            //UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuAction))
    }
    
    @objc func menuAction(){
        self.sideMenuViewController.presentLeftMenuViewController()
    }
    
    func getParam(){
        AppDelegate.appDelegate().showLoading()
        let query = AVQuery(className: "GetVersion")
        query.includeKey("version")
        query.includeKey("appStoreURL")
        let array = query.findObjects()
        AppDelegate.appDelegate().hideLoading()
        
        guard array != nil else {
            setUpUI()
            configTableView()
            MovieListViewModel.movieListViewModel.fetchData()
            MovieListViewModel.movieListViewModel.didSelectModelBlock = { model in
                let detailViewcontroller = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
                detailViewcontroller.movieModel = model
                self.navigationController?.pushViewController(detailViewcontroller, animated: true)
            }
            MovieListViewModel.movieListViewModel.reloadTableViewBlock = {
                self.tableView.reloadData()
                self.splashImageView.isHidden = true
            }
            
            return
        }
        
        if (array?.count)! > 0 {
            let model: AVObject = array![0] as! AVObject
            print(model)
            print(model.object(forKey: "version"))
            if (model.object(forKey: "version") as! String) == "1.0" {
                setUpUI()
                configTableView()
                MovieListViewModel.movieListViewModel.fetchData()
                MovieListViewModel.movieListViewModel.didSelectModelBlock = { model in
                    let detailViewcontroller = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
                    detailViewcontroller.movieModel = model
                    self.navigationController?.pushViewController(detailViewcontroller, animated: true)
                }
                MovieListViewModel.movieListViewModel.reloadTableViewBlock = {
                    self.tableView.reloadData()
                    self.splashImageView.isHidden = true
                }
            }else{
                // hien thi webview
                self.splashImageView.isHidden = true
                if let link = model["appStoreURL"] as? String {
                    let webVC = WebViewController(nibName: "WebViewController", bundle: nil )//SwiftWebVC(urlString: link as! String)
                    webVC.appStoreURL = link
                    self.navigationController?.isNavigationBarHidden = true
                    self.navigationController?.pushViewController(webVC, animated: false)
                }
            }
        }
    }
}
