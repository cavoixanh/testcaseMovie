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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
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

    }
}
