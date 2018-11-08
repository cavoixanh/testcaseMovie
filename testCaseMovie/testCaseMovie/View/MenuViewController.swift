//
//  MenuViewController.swift
//  testCaseMovie
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let arrTitle = ["    Home","    Saved Movies","    About Us","    Support"]
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify = "Identify\(indexPath.row)"
        var cell = tableView.dequeueReusableCell(withIdentifier: identify)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identify)
        }
        
        cell?.contentView.backgroundColor = UIColor(rgb: 0x161D25)
        cell?.textLabel?.text = arrTitle[indexPath.row]
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cell?.textLabel?.textColor = UIColor.white
        
        switch indexPath.row {
        case 0:
            cell?.imageView?.image = UIImage(named: "135_icon")
            break;
        case 1:
            cell?.imageView?.image = UIImage(named: "saved_icon")
            break;
        case 2:
            cell?.imageView?.image = UIImage(named: "about_icon")
            break;
        default:
            cell?.imageView?.image = UIImage(named: "support_icon")
            break;
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        AppDelegate.appDelegate().changeMenu(index: indexPath.row)
    }

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
