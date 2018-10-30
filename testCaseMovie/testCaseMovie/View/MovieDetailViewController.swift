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
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x273446)
        self.navigationController?.navigationBar.topItem?.title = movieModel?.title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
