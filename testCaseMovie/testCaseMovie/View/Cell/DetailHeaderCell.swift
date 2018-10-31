//
//  DetailHeaderCell.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class DetailHeaderCell: UITableViewCell {

    @IBOutlet var headerImageView : UIImageView!
    @IBOutlet var avatarImageView : UIImageView!
    @IBOutlet var titleLabel      : UILabel!
    @IBOutlet var subTitleLabel   : UILabel!
    
    
    func setMovieDetail(aMovieDetail: MovideDetailModel){
        
        self.titleLabel.text = aMovieDetail.title
        self.subTitleLabel.text = aMovieDetail.tagline
        
        let backDropPath = API.imageThumnbUrl + (aMovieDetail.backdrop_path ?? "")
        APIService.shared.requestImage(path: backDropPath) { (image) in
            self.headerImageView.image = image
        }
        
        let posterPath = API.imageThumnbUrl + (aMovieDetail.poster_path ?? "")
        APIService.shared.requestImage(path: posterPath) { (image) in
            self.avatarImageView.image = image
        }
    }
}
