//
//  MovieSaveViewController.swift
//  testCaseMovie
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MovieSaveViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        
        let realm = try! Realm()
        let puppies = realm.objects(MovieRealmModel.self)
        let array = puppies.toArray(ofType: MovieRealmModel.self)
        MovieSaveViewModel.movieSaveViewModel.movieModelArray = array
        
        tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = MovieSaveViewModel.movieSaveViewModel
        tableView.dataSource = MovieSaveViewModel.movieSaveViewModel
        tableView.reloadData()
        MovieSaveViewModel.movieSaveViewModel.didSelectModelBlock = { model in
            let detailViewcontroller = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
            let tempmodel = MovieModel(dict: [:])
            tempmodel.id = Int64(model.id)
            tempmodel.title = model.title
            detailViewcontroller.movieModel = tempmodel
            self.navigationController?.pushViewController(detailViewcontroller, animated: true)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        let puppies = realm.objects(MovieRealmModel.self)
        let array = puppies.toArray(ofType: MovieRealmModel.self)
        MovieSaveViewModel.movieSaveViewModel.movieModelArray = array
        self.tableView.reloadData()
    }
    
    func addLeftIcon(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_icon")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(menuAction))
        //UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuAction))
    }
    
    @objc func menuAction(){
        self.sideMenuViewController.presentLeftMenuViewController()
    }
    
    func setUpUI(){
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x273446)
        self.navigationItem.title = "SAVED MOVIES";
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        addLeftIcon()
    }

}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        let array = Array(self) as! [T]
        return array
    }
}
