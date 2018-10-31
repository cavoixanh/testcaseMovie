//
//  DetailContentCellViewModel.swift
//  testCaseMovie
//
//  Created by admin on 10/31/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class DetailContentCellViewModel {

    static let detailContentCellViewModel = DetailContentCellViewModel()
    var detailModel: MovideDetailModel!
    
    func getGenres()-> String {
        
        var genreString = ""
        
        for model in (self.detailModel.genres ?? []) {
            genreString = genreString + " " + (model.name ?? "") + ","
        }
        
        return String(genreString.dropFirst().dropLast());
    }
    
    func getCompanies() -> String {
        var companiesString = ""
        for model in (self.detailModel.production_companies ?? []) {
            companiesString = companiesString + " " + (model.name ?? "") + ","
        }
        return String(companiesString.dropFirst().dropLast())
    }
    
    func formatMoney(money: Float64?) -> String {
        guard let money = money else {
            return ""
        }
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedAmount = formatter.string(from: money as! NSNumber) {
            return "\(formattedAmount)"
        }
        
        return ""
    }
    
}
