//
//  MovieListCell.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var thumbImage: UIImageView!
    
    
    var movieModel : MovieModel?
    var minHeight: CGFloat?
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minHeight = minHeight else { return size }
        return CGSize(width: size.width, height: max(size.height, minHeight))
    }
    
    func setMovieModel(aMovieModel: MovieModel){
        self.movieModel = aMovieModel
        self.thumbImage.image = nil
        titleLabel.text = aMovieModel.title
        dateLabel.text = aMovieModel.release_date
        descriptionLabel.text = aMovieModel.overview
        let path = API.imageThumnbUrl + (aMovieModel.poster_path ?? "")
        APIService.shared.requestImage(path: path) { (image) in
            self.thumbImage.image = image
        }
    }
    
}
