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
        tableView.delegate = MovieDetailViewModel.movieDetailViewModel
        tableView.dataSource = MovieDetailViewModel.movieDetailViewModel
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "DetailHeaderCell", bundle: nil), forCellReuseIdentifier: "DetailHeaderCell")
        tableView.register(UINib(nibName: "DetailContentCell", bundle: nil), forCellReuseIdentifier: "DetailContentCell")
        MovieDetailViewModel.movieDetailViewModel.fetchDetail(aMovieID: Int32(movieModel?.id ?? 0))
        MovieDetailViewModel.movieDetailViewModel.reloadTableViewBlock = {
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        self.navigationItem.setHidesBackButton(true, animated:true);
        let backButton = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(backAction))
        self.navigationController?.navigationItem.leftBarButtonItems = [backButton]
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x273446)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
}
