//
//  MovieDetailViewController.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var movieModel : MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.configTableView()
        MovieDetailViewModel.movieDetailViewModel.reloadTableViewBlock = {
            self.tableView.reloadData()
        }
        
        MovieDetailViewModel.movieDetailViewModel.fetchDetail(aMovieID: (Int64(movieModel?.id ?? 0)))
    }
    
    func setUpUI(){
        self.navigationItem.setHidesBackButton(true, animated:true);
        let backButton = UIBarButtonItem(image: UIImage(named: "ic_back")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItems = [backButton]
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x273446)
        self.navigationItem.title = movieModel?.title;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func configTableView(){
        tableView.delegate = MovieDetailViewModel.movieDetailViewModel
        tableView.dataSource = MovieDetailViewModel.movieDetailViewModel
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "DetailHeaderCell", bundle: nil), forCellReuseIdentifier: "DetailHeaderCell")
        tableView.register(UINib(nibName: "DetailContentCell", bundle: nil), forCellReuseIdentifier: "DetailContentCell")
    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
}
