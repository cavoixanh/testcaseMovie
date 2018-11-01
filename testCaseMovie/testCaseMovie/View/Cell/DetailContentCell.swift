//
//  DetailContentCell.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class DetailContentCell: UITableViewCell {

    var indexPath: IndexPath?
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel  : UILabel!
    
    func setMovieDetail(aMovieDetail: MovideDetailModel){
        DetailContentCellViewModel.detailContentCellViewModel.detailModel = aMovieDetail
        var titleString = ""
        var contenString = ""
        
        switch self.indexPath?.row {
        case 1:
            titleString = "Overview"
            contenString = aMovieDetail.overview ?? ""
            break;
        case 2:
            titleString = "Genres"
            contenString = DetailContentCellViewModel.detailContentCellViewModel.getGenres()
            break;
        case 3:
            titleString = "Duration"
            contenString = aMovieDetail.runtime == nil ? "" : "\(aMovieDetail.runtime!) Minutes"
            break;
        case 4:
            titleString = "Release Date"
            contenString = aMovieDetail.release_date ?? ""
            break;
        case 5:
            titleString = "Production Companies"
            contenString = DetailContentCellViewModel.detailContentCellViewModel.getCompanies()
            break;
        case 6:
            titleString = "Production Budget"
            contenString = DetailContentCellViewModel.detailContentCellViewModel.formatMoney(money: aMovieDetail.budget)
            break;
        case 7:
            titleString = "Revenue"
            contenString = DetailContentCellViewModel.detailContentCellViewModel.formatMoney(money: aMovieDetail.revenue)
            break;
        case 8:
            titleString = "Languages"
            contenString = aMovieDetail.original_language ?? ""
            break;
        default:
            break
         }
        
        self.titleLabel.text = titleString
        self.contentLabel.text = contenString
    }
}
