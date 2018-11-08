//
//  MovieDetailViewController.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import MBProgressHUD
import Realm
import RealmSwift


class MovieDetailViewController: UIViewController, UIActionSheetDelegate {

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
        addRightIcon()
    }
    
    func addRightIcon(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "more_icon")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(menuAction))
        
    }
    
    @objc func menuAction(){
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let realm = try! Realm()
        let result = realm.objects(MovieRealmModel.self).filter("id = \(movieModel?.id ?? -1)")
        if result.count > 0 {
            let deleteActionButton = UIAlertAction(title: "UnSave", style: .default)
            { _ in
                
                let model = MovieRealmModel(dict: self.movieModel!)
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(result.first!)
                }
                
                //print("Save")
            }
            actionSheetControllerIOS8.addAction(deleteActionButton)
        }else{
            let saveActionButton = UIAlertAction(title: "Save", style: .default)
            { _ in
                
                let model = MovieRealmModel(dict: self.movieModel!)
                let realm = try! Realm()
                try! realm.write {
                    realm.add(model, update: true)
                }
                
                //print("Save")
            }
            actionSheetControllerIOS8.addAction(saveActionButton)
        }
        
        
        
        
        let deleteActionButton = UIAlertAction(title: "Share", style: .default)
        { _ in
            print("share")
            let image = UIImage(named: "next_icon")
            let text = self.movieModel?.title
            
            // set up activity view controller
            let imageToShare = [ text,image! ] as [Any]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
}
