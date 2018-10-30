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
        MovieListViewModel.movieListViewModel.fetchData()
        tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
        tableView.delegate = MovieListViewModel.movieListViewModel
        tableView.dataSource = MovieListViewModel.movieListViewModel
        tableView.estimatedRowHeight = UITableView.automaticDimension
        MovieListViewModel.movieListViewModel.reloadTableView = {
            self.tableView.reloadData()
        }
    }
}
